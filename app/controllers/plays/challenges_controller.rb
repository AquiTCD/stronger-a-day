class Plays::ChallengesController < BaseController
  def new
    @play = current_user.plays.find(params[:play_id])
    # 未達成かつキャラクター指定が合うもの or 指定がないもの を相手でソート
    @challenges =
      current_user.challenges.not_achieved.where(game: @game, character_id: nil).
        or(current_user.challenges.not_achieved.where(game: @game, character_id: @play.character_id)).
        includes(:opponent, :character).
        order(Arel.sql("opponent_id IS NOT NULL, opponent_id ASC"))

    # selectedにしてあるものか、既にPlayにひもづいてるもの（戻ってきた場合）
    @playing_challenge_ids = @play.challenges.pluck(:challenge_id)
    @selected_challenge_ids = @playing_challenge_ids.presence || @challenges.selected.pluck(:id)
  end

  def create
    error = validate_create_param!
    return redirect_to new_game_play_challenge_path(@game, create_params[:play_id]), flash: { error: } if error

    play = current_user.plays.find(create_params[:play_id])
    playing_challenges = play.challenges
    ActiveRecord::Base.transaction do
      # 画面から来たものに以外（=選択されなかったもの）があれば削除と思ったが、減らせないようにする
      # deleting = @playing_challenges.where.not(challenge_id: create_params[:challenge_ids])
      # deleting&.destroy_all

      # 選択された中間テーブルを保存しつつ、playをin_progressにする
      playing_challenge_ids = playing_challenges.pluck(:challenge_id)
      create_params[:challenge_ids].each do |challenge_id|
        next if playing_challenge_ids.include?(challenge_id.to_i)

        Play::Challenge.create!(play_id: create_params[:play_id], challenge_id:)
      end
      play.in_progress!
    end
    notice = "「#{play.character.display_name}」でプレイを開始します"
    redirect_to new_game_play_result_path(@game, create_params[:play_id]), notice:
  end

  private

    def create_params
      params.permit(:play_id, challenge_ids: [])
    end

    def validate_create_param!
      return if create_params[:challenge_ids].present?

      "チャレンジする課題を選択してください"
    end
end
