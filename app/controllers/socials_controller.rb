class SocialsController < BaseController
  def show
    @challenges =
      Challenge.where.not(user: [User.system, current_user]).where(game: @game).where.missing(:referred_from).where(public: true).order("RANDOM()").
        includes(:referred_tos).limit(25)
  end

  def copy_challenge
    challenge = Challenge.find(params[:challenge_id])
    challenge.copy_to(current_user)
    redirect_to game_social_path(@game), flash: { success: "チャレンジをコピーしました" }
  end
end
