class TrainingsController < BaseController
  before_action :set_training, only: [:show, :edit, :update, :destroy, :achieve]

  def index
    user_trainings = current_user.trainings.where(user: current_user, game: @game)
    @trainings = user_trainings.not_achieved.order(:id)
    @training = Training.new(user: current_user, game: @game)
    @recipes = current_user.recipes.where(game: @game)
    @characters = Character.where(game: @game)

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
      @characters = Character.where(game: @game)
      @recipes = current_user.recipes.where(game: @game)
      flash.now.notice = "チャレンジを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @characters = Character.where(game: @game)
    @recipes = current_user.recipes.where(game: @game)
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
    if @training.save
      if @training.achieved_at
        flash.now[:success] = "「#{@training.topic}」\nを達成にしました"
      else
        flash.now.alert = "「#{@training.topic}」\nの達成を取り消しました"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @training.destroy
      flash.now.alert = "チャレンジを削除しました"
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
end
