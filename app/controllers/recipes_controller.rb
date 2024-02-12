class RecipesController < BaseController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = current_user.recipes.where(user: current_user, game: @game)
    @recipe = Recipe.new(user: current_user, game: @game)
    @characters = Character.where(game: @game)
    @situations = Situation.where(game: @game)
  end

  def show
  end

  def create
    @recipe = current_user.recipes.new(
      user: current_user,
      game: @game,
      character_id: recipe_params[:character_id],
      movements: recipe_params[:movements],
      comment: recipe_params[:comment],
      public: recipe_params[:public],
    )
    ActiveRecord::Base.transaction do
      @recipe.save!
      recipe_params[:situation_ids]&.each do |s_id|
        @recipe.recipe_situations.create!(situation_id: s_id.to_i)
      end
    end
    @characters = Character.where(game: @game)
    @situations = Situation.where(game: @game)
    flash.now.notice = "レシピを追加しました"
  end

  def edit
    @characters = Character.where(game: @game)
    @situations = Situation.where(game: @game)
  end

  def update
    ActiveRecord::Base.transaction do
      @recipe.update!(recipe_params)

      # 画面から来たものに以外（=選択されなかったもの）があれば削除
      deleting = @recipe.recipe_situations.where.not(situation_id: recipe_params[:situations_ids].map(&:to_i))
      deleting.each(&:destroy!)

      # 増えたものを追加
      existing_situation_ids = @recipe.recipe_situations.pluck(:situation_id)
      recipe_params[:situation_ids]&.each do |s_id|
        id = s_id.to_i
        next if existing_situation_ids.include?(id)

        @recipe.recipe_situations.create!(situation_id: id)
      end
    end
    notice = "更新しました"
    redirect_to game_recipe_path(@game, @recipe), notice:
  end

  def destroy
    if @recipe.destroy
      flash.now.alert = "レシピを削除しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def recipe_params
      params.require(:recipe).permit(:character_id, :movements, :comment, :public, situation_ids: [])
    end

    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    end
end
