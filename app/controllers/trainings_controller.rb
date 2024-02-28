class TrainingsController < BaseController
  before_action :set_training, only: [:show, :edit, :update, :destroy, :achieve, :do, :done]

  def index
    user_trainings =
      current_user.trainings.where(user: current_user, game: @game).
        includes(:character, recipe: [:situations, :character, { recipe_situations: :situation }])
    @trainings = user_trainings.not_achieved.order(:id)
    @training = Training.new(user: current_user, game: @game)
    @recipes = current_user.recipes.where(game: @game)
    @characters = @game.characters

    @results = Training::Result.where(training: user_trainings).order(created_at: :desc).limit(25)
    @achieved_trainings = user_trainings.achieved.order(achieved_at: :desc)
  end

  def show
  end

  def create
    @training = Training.new(
      user: current_user,
      game: @game,
      topic: training_params[:topic],
      character_id: training_params[:character_id],
      recipe_id: training_params[:recipe_id],
      public: training_params[:public],
    )
    if @training.save
      @characters = @game.characters
      @recipes = current_user.recipes.where(game: @game)
      flash.now.notice = "トレーニングを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @characters = @game.characters
    @recipes = current_user.recipes.where(game: @game)
  end

  def do
  end

  def done
    if @training.results.create(done_params)
      flash.now.notice = "トレーニングを記録しました"
      @result = @training.results.last
    else
      render :do, status: :unprocessable_entity
    end
  end

  def update
    if @training.update(training_params)
      notice = "更新しました"
      redirect_to game_training_path(@game, @training), notice:
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def achieve
    @training.achieved_at = if @training.achieved_at
                              nil
                            else
                              Time.current
                            end
    full_name = "#{@training.recipe&.movements}#{@training.topic}"
    if @training.save
      if @training.achieved_at
        flash.now[:success] = "「#{full_name}」\nを達成にしました"
      else
        flash.now.alert = "「#{full_name}」\nの達成を取り消しました"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @training.destroy
      flash.now.alert = "トレーニングを削除しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # def copy_sample
  #   user = User.system
  #   user.trainings.where(game: @game).each do |training|
  #     training.copy_to(current_user)
  #   end
  #   flash.now.notice = "サンプルチャレンジを追加しました"
  #   redirect_to game_trainings_path(@game)
  # end

  private

    def training_params
      params.require(:training).permit(:topic, :recipe_id, :character_id, :public)
    end

    def set_training
      @training = current_user.trainings.find(params[:id])
    end

    def complete_params
      params.permit(:id)
    end

    def done_params
      params.require(:training).permit(:comment)
    end
end
