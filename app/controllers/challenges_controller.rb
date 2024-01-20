class ChallengesController < BaseController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  def index
    @challenges = Challenge.where(user: current_user, game: @game).order(:id)
    @challenge = Challenge.new(user: current_user, game: @game)
  end

  def new
    @challenge = Challenge.new(user: current_user, game: @game)
  end

  def show
  end

  def create
    @challenge = Challenge.new(
      user: current_user,
      game: @game,
      topic: challenge_params[:topic],
    )
    if @challenge.save
      flash.now.notice = "登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @challenge.update(challenge_params)
      flash.now.notice = "更新しました。"
      redirect_to challenge_path(@game, @challenge)
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
      params.require(:challenge).permit(:topic)
    end

    def set_challenge
      @challenge = Challenge.find(params[:id])
    end
end
