class ReviewsController < BaseController
  def index
    characters = @game.characters
    user_plays = current_user.plays.
                   where(character: characters).
                   where.associated(:play_results)
    @plays = user_plays.finished.order(id: :desc).
               includes(:play_results, play_challenges: :challenge)

    total_plays = user_plays.reviewed
    total_results = PlayResult.where(play: total_plays)
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
    @play = current_user.plays.find(params[:play_id])
    @play.reviewed!

    challenges = @play.challenges
    challenges.not_achieved.update_all(selected: true)
    challenges.achieved.update_all(selected: false)

    @achieved_challenges = current_user.challenges.where(game: @game).achieved.order(achieved_at: :desc)

    flash.now[:success] = "#{@play.started_at.strftime("%Y/%m/%d")}}\nのプレイをレビュー完了にしました"
  end
end
