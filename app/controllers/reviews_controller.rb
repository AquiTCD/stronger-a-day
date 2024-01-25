class ReviewsController < BaseController
  def index
    characters = @game.characters
    dailies = current_user.dailies.where(character: characters).where.associated(:daily_results)
    @latest_daily = dailies.finished.order(id: :desc).first
    @latest_results = @latest_daily.daily_results
    @win_count = @latest_results.sum(:win_count)
    @lose_count = @latest_results.sum(:lose_count)
    @latest_daily_challenges = @latest_daily.daily_challenges.includes(:challenge)

    total_dailies = dailies.reviewed
    total_results = DailyResult.where(daily: total_dailies)
    @total_win_count = total_results.sum(:win_count)
    @total_lose_count = total_results.sum(:lose_count)
  end

  def achieve_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
    @challenge.achieved_at = if @challenge.achieved_at
                               nil
                             else
                               Time.current
                             end
    if @challenge.save
      # redirect_to game_challenge_path(@game, @challenge)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def complete_review
    daily = current_user.dailies.find(params[:daily_id])
    daily.reviewed!
  end
end
