class ReviewsController < BaseController
  def index
    characters = @game.characters
    user_plays = current_user.plays.
                   where(character: characters).
                   where.associated(:results).distinct
    @plays = user_plays.finished.order(id: :desc).
               includes(:results)

    @reviewed_plays = user_plays.reviewed
    total_results = Play::Result.where(play: @reviewed_plays).pluck(:result)

    @total_win_count = total_results.count("win")
    @total_lose_count = total_results.count("lose")

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

  def complete
    @play = current_user.plays.find(params[:id])
    @play.comment = complete_params[:comment] if complete_params[:comment].present?
    @play.reviewed!

    challenges = @play.challenges
    challenges.not_achieved.update_all(selected: true)
    challenges.achieved.update_all(selected: false)

    @achieved_challenges = current_user.challenges.where(game: @game).achieved.order(achieved_at: :desc)

    flash.now[:success] = "#{@play.started_at.strftime("%Y/%m/%d %H:%M")}\nのプレイをレビュー完了にしました"
  end

  private

    def complete_params
      params.permit(:id, :comment)
    end
end
