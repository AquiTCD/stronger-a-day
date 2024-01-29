class PlaysController < BaseController
  def new
    # TODO: playing ならモーダル
    # 終了して新しいキャラ選択 or 続きから
    @playing = current_user.plays.where(character: @game.characters).where.associated(:play_results).in_progress.first

    @play = current_user.plays.new
    @characters = @game.characters
  end

  def create
    user_plays = current_user.plays
    # まだ関連データがないものを削除
    user_plays.where.missing(:play_results).destroy_all

    @play = current_user.plays.new(character_id: play_params[:character_id])
    if @play.save
      redirect_to new_game_play_challenge_path(@game, @play)
    else
      render :create, status: :unprocessable_entity
    end
  end

  def finish
    @play = current_user.plays.find(params[:id])
    @play.finished!

    case params[:move_to]
    when "review"
      notice = "プレイを終了しました\n続けて振り返りレビューを行います"
      redirect_to game_reviews_path(@game), notice:
    when "new"
      notice = "プレイを終了しました\n新しいプレイを開始します"
      redirect_to new_game_play_path(@game), notice:
    else
      alert = "プレイを終了しました\n次のプレイを開始前に振り返りを忘れずに"
      redirect_to game_path(@game), alert:
    end
  end

  private

    def play_params
      params.permit(:character_id, :started_at)
    end
end
