class ChallengesController < BaseController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :start]

  def index
    user_challenges = current_user.challenges.where(game: @game).includes(:character, :opponent)
    @challenges = user_challenges.not_achieved.order(:id)
    @challenge = Challenge.new(user: current_user, game: @game)
    @characters = @game.characters

    @achieved_challenges = user_challenges.achieved.order(achieved_at: :desc)
  end

  def show
  end

  def create
    @challenge = Challenge.new(
      user: current_user,
      game: @game,
      topic: challenge_params[:topic],
      character_id: challenge_params[:character_id],
      opponent_id: challenge_params[:opponent_id],
      public: challenge_params[:public],
    )
    if @challenge.save
      @characters = @game.characters
      flash.now.notice = "チャレンジを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def add
    @challenge = Challenge.new(
      user: current_user,
      game: @game,
      topic: challenge_params[:topic],
      character_id: challenge_params[:character_id],
      opponent_id: challenge_params[:opponent_id],
      public: challenge_params[:public],
    )
    if @challenge.save
      flash.now.notice = "課題を追加しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @characters = @game.characters
  end

  def update
    if @challenge.update(challenge_params)
      notice = "更新しました"
      redirect_to game_challenge_path(@game, @challenge), notice:
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def start
    @challenge.toggle(:selected)
    if @challenge.save
      redirect_to game_challenge_path(@game, @challenge)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @challenge.destroy
      flash.now.alert = "チャレンジを削除しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def copy_sample
    user = User.system
    user.challenges.where(game: @game).each do |challenge|
      challenge.copy_to(current_user)
    end
    flash.now.notice = "サンプルチャレンジを追加しました"
    redirect_to game_challenges_path(@game)
  end

  private

    def challenge_params
      params.require(:challenge).permit(:topic, :character_id, :opponent_id, :public)
    end

    def set_challenge
      @challenge = Challenge.find(params[:id])
    end
end
