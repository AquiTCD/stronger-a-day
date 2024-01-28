class DailiesController < BaseController
  def new
    @daily = current_user.dailies.new
    @characters = @game.characters
  end

  def create
    user_dailies = current_user.dailies
    # まだ関連データがないものを削除
    user_dailies.where(daily_results: nil).destroy_all

    existed_dailies = user_dailies.where(character_id: daily_params[:character_id], tried_on: Date.today)
    round = existed_dailies.size + 1
    @daily = current_user.dailies.new(
      character_id: daily_params[:character_id],
      tried_on: Date.today,
      round:,
    )
    if @daily.save
      redirect_to new_game_daily_challenge_path(@game, @daily)
    else
      render :create, status: :unprocessable_entity
    end
  end

  def finish
    @daily = current_user.dailies.find(params[:id])
    @daily.finished!

    if params[:to_review] == "true"
      notice = "プレイを終了しました\n続けて振り返りレビューを行います"
      redirect_to game_reviews_path(@game), notice:
    else
      alert = "プレイを終了しました\n次のプレイを開始前に振り返りを忘れずに"
      redirect_to game_path(@game), alert:
    end
  end

  private

    def daily_params
      params.permit(:character_id, :tried_on)
    end
end
