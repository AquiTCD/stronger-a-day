class RecipesController < BaseController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    recipes = current_user.recipes.where(game: @game).includes(:character, :situations, recipe_situations: :situation)
    recipes = recipes.where(character_id: [nil, params[:character_id]]) if params[:character_id].present?
    @recipes =
      recipes.order(Arel.sql("character_id IS NOT NULL, character_id ASC")).order(:id)

    @recipe = Recipe.new(user: current_user, game: @game)
    @characters = current_user.selectable_characters(@game).order(:kana)
    @situations = @game.situations

    @filters = { character_id: params[:character_id] }
  end

  def show
    @filters = { character_id: params[:character_id] }
  end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    recipe = current_user.recipes.new(
      user: current_user,
      game: @game,
      character_id: recipe_params[:character_id],
      movements: recipe_params[:movements],
      comment: recipe_params[:comment],
      public: recipe_params[:public],
    )
    ActiveRecord::Base.transaction do
      recipe.save!
      recipe_params[:situation_ids]&.each do |s_id|
        recipe.recipe_situations.create!(situation_id: s_id.to_i)
      end
    end
    @characters = @game.characters.order(:kana)
    @situations = @game.situations
    recipes = current_user.recipes.where(game: @game).includes(:character, :situations, recipe_situations: :situation)
    recipes = recipes.where(character_id: [nil, filters[:character_id]]) if filters[:character_id].present?
    @recipes =
      recipes.order(Arel.sql("character_id IS NOT NULL, character_id ASC")).order(:id)
    if current_user.keep_selection
      @selected_character_id = recipe_params[:character_id]
    end
    flash.now[:success] = "レシピを追加しました"
  end

  def edit
    @characters = current_user.selectable_characters(@game).order(:kana)
    @situations = @game.situations
    @filters = { character_id: params[:character_id] }
  end

  def update # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity
    ActiveRecord::Base.transaction do
      @recipe.update!(recipe_params)

      # 画面から来たものに以外（=選択されなかったもの）があれば削除
      deleting = @recipe.recipe_situations.where.not(situation_id: recipe_params[:situations_ids]&.map(&:to_i))
      deleting.each(&:destroy!) if deleting.present?

      # 増えたものを追加
      existing_situation_ids = @recipe.recipe_situations.pluck(:situation_id)
      recipe_params[:situation_ids]&.each do |s_id|
        id = s_id.to_i
        next if existing_situation_ids.include?(id)

        @recipe.recipe_situations.create!(situation_id: id)
      end
    end
    recipes = current_user.recipes.where(game: @game).includes(:character, :situations, recipe_situations: :situation)
    recipes = recipes.where(character_id: [nil, filters[:character_id]]) if filters[:character_id].present?
    @recipes =
      recipes.order(Arel.sql("character_id IS NOT NULL, character_id ASC")).order(:id)

    flash.now[:success] = "更新しました"
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

    def filters
      @filters ||= params.require(:filters).permit(:character_id)
    end

    def set_recipe
      @recipe = current_user.recipes.find(params[:id])
    end
end
