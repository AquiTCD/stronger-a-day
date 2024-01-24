class DailyChallengesController < BaseController
  def new
    @daily = current_user.dailies.find(params[:daily_id])
    @challenges = current_user.challenges.where(game: @game)
    @selected_challenge_ids = @daily.daily_challenges.pluck(:challenge_id)
  end

  def create
    daily = current_user.dailies.find(params[:daily_id])
    @selected_challenges = daily.daily_challenges
    ActiveRecord::Base.transaction do
      deleting = @selected_challenges.where.not(challenge_id: daily_challenge_params[:challenge_ids])
      deleting&.destroy_all

      daily_challenge_params[:challenge_ids].each do |challenge_id|
        next if @selected_challenges.present? && @selected_challenges.pluck(:challenge_id).include?(challenge_id.to_i)

        DailyChallenge.create!(daily_id: params[:daily_id], challenge_id:)
      end
    end
    redirect_to new_game_daily_result_path(@game, params[:daily_id])
  end

  private

    def daily_challenge_params
      params.permit(:daily_id, challenge_ids: [])
    end
end
