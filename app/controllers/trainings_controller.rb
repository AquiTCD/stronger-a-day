class TrainingsController < BaseController # rubocop:disable Metrics/ClassLength
  before_action :set_training, only: [:show, :edit, :update, :destroy, :achieve, :do, :done]

  def index
    trainings =
      current_user.trainings.where(user: current_user, game: @game).
        includes(:character, recipe: [:situations, :character, { recipe_situations: :situation }])
    trainings = trainings.where(character_id: [nil, params[:character_id]]) if params[:character_id].present?
    @trainings = trainings.not_achieved.order(:id)
    @training = Training.new(user: current_user, game: @game)
    @characters = current_user.selectable_characters(@game)
    @recipes = current_user.recipes.where(game: @game, character: @characters).includes(:character)

    @results = Training::Result.where(training: trainings).order(created_at: :desc).limit(25)
    @achieved_trainings = trainings.achieved.order(achieved_at: :desc)
  end

  def show
  end

  def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    character_id =
      if training_params[:recipe_id].present?
        current_user.recipes.find(training_params[:recipe_id])&.character_id
      else
        training_params[:character_id].presence
      end

    training = Training.new(
      user: current_user,
      game: @game,
      topic: training_params[:topic],
      character_id:,
      recipe_id: training_params[:recipe_id],
      public: training_params[:public],
    )
    if training.save
      @characters = @game.characters
      @recipes = current_user.recipes.where(game: @game).includes(:character)
      trainings =
        current_user.trainings.not_achieved.where(user: current_user, game: @game).
          includes(:character, recipe: [:situations, :character, { recipe_situations: :situation }])
      trainings = trainings.where(character_id: [nil, filters_params[:character_id]]) if filters_params[:character_id].present?
      @trainings = trainings.order(:id)
      if current_user.keep_selection
        @selected_character_id = character_id
      end
      flash.now[:success] = "トレーニングを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @characters = current_user.selectable_characters(@game)
    @recipes = current_user.recipes.where(game: @game, character: @characters).includes(:character)
  end

  def do
  end

  def done
    if @training.results.create(done_params)
      flash.now[:success] = "トレーニングを記録しました"
      @result = @training.results.last
    else
      render :do, status: :unprocessable_entity
    end
  end

  def update
    if @training.update(training_params)
      flash.now[:success] = "更新しました"
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

  private

    def training_params
      params.require(:training).permit(:topic, :recipe_id, :character_id, :public)
    end

    def filters_params
      params.require(:filters).permit(:character_id)
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
