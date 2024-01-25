class ReviewsController < BaseController
  def index
    characters = @game.characters
    user_dailies = current_user.dailies.
                     where(character: characters).
                     where.associated(:daily_results)
    @dailies = user_dailies.finished.order(id: :desc).
                 includes(:daily_results, daily_challenges: :challenge)

    total_dailies = user_dailies.reviewed
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
      flash.now.notice =
        if @challenge.achieved_at
          "「#{@challenge.topic}」を達成にしました"
        else
          "「#{@challenge.topic}」の達成を取り消しました"
        end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def complete_review
    @daily = current_user.dailies.find(params[:daily_id])
    @daily.reviewed!
    flash.now.notice = "#{@daily.tried_on.strftime("%Y/%m/%d")}: ROUND #{@daily.round} のプレイをレビュー完了にしました"
  end
end
