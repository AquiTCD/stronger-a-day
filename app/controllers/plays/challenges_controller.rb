class Plays::ChallengesController < BaseController
  def new
    @play = current_user.plays.find(params[:play_id])
    @challenges = current_user.challenges.where(game: @game).not_achieved.order(Arel.sql("opponent_id IS NOT NULL, opponent_id ASC"))
    @selected_challenge_ids = if @play.play_challenges.pluck(:challenge_id).present?
                                @play.play_challenges.pluck(:challenge_id)
                              else
                                @challenges.selected.pluck(:id)
                              end
  end

  def create # rubocop:disable Metrics/AbcSize
    error = validate_create_param!
    return redirect_to new_game_play_challenge_path(@game, params[:play_id]), flash: { error: } if error

    play = current_user.plays.find(params[:play_id])
    @selected_challenges = play.play_challenges
    ActiveRecord::Base.transaction do
      deleting = @selected_challenges.where.not(challenge_id: play_challenge_params[:challenge_ids])
      deleting&.destroy_all

      play_challenge_params[:challenge_ids].each do |challenge_id|
        next if @selected_challenges.present? && @selected_challenges.pluck(:challenge_id).include?(challenge_id.to_i)

        PlayChallenge.create!(play_id: params[:play_id], challenge_id:)
      end
      play.in_progress!
    end
    notice = "「#{play.character.display_name}」でプレイを開始します"
    redirect_to new_game_play_result_path(@game, params[:play_id]), notice:
  end

  private

    def play_challenge_params
      params.permit(:play_id, challenge_ids: [])
    end

    def validate_create_param!
      return if play_challenge_params[:challenge_ids].present?

      "チャレンジする課題を選択してください"
    end
end
