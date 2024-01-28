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

    @achieved_challenges = current_user.challenges.where(game: @game).achieved.order(achieved_at: :desc)
  end

  def achieve_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
    @challenge.achieved_at = if @challenge.achieved_at
                               nil
                             else
                               Time.current
                             end
    if @challenge.save
      if @challenge.achieved_at
        flash.now[:success] = "「#{@challenge.topic}」\nを達成にしました"
      else
        flash.now.alert = "「#{@challenge.topic}」\nの達成を取り消しました"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def complete_review
    @daily = current_user.dailies.find(params[:daily_id])
    @daily.reviewed!

    challenges = @daily.challenges
    challenges.not_achieved.update_all(in_progress: true)
    challenges.achieved.update_all(in_progress: false)

    @achieved_challenges = current_user.challenges.where(game: @game).achieved.order(achieved_at: :desc)

    flash.now[:success] = "#{@daily.tried_on.strftime("%Y/%m/%d")}: ROUND #{@daily.round}\nのプレイをレビュー完了にしました"
  end
end
