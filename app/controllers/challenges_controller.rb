class ChallengesController < BaseController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :start]

  def index
    user_challenges = current_user.challenges.where(user: current_user, game: @game)
    @challenges = user_challenges.not_achieved.order(:id)
    @challenge = Challenge.new(user: current_user, game: @game)
    @opponents = Character.where(game: @game)

    @achieved_challenges = user_challenges.achieved.order(achieved_at: :desc)
  end

  def show
  end

  def create
    @challenge = Challenge.new(
      user: current_user,
      game: @game,
      topic: challenge_params[:topic],
      opponent_id: challenge_params[:opponent_id],
      private: challenge_params[:private],
    )
    if @challenge.save
      @opponents = Character.where(game: @game)
      flash.now.notice = "登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @opponents = Character.where(game: @game)
  end

  def update
    if @challenge.update(challenge_params)
      flash.now.notice = "更新しました。"
      redirect_to game_challenge_path(@game, @challenge)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def start
    @challenge.toggle(:in_progress)
    if @challenge.save
      redirect_to game_challenge_path(@game, @challenge)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @challenge.destroy
      flash.now.notice = "削除しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def challenge_params
      params.require(:challenge).permit(:topic, :opponent_id, :private)
    end

    def set_challenge
      @challenge = Challenge.find(params[:id])
    end
end
