class Plays::ResultsController < BaseController
  before_action :set_play

  def new
    @general_challenges = @play.challenges.where(opponent: nil)
    @opponents = @game.characters
    results = @play.play_results
    @win_count = results.sum(:win_count)
    @lose_count = results.sum(:lose_count)
  end

  def create
    result_form = ResultForm.initialize_by_params(play_result_params)
    result_form.save_result!

    notice = "結果を記録しました\n次の相手を選択してください"
    redirect_to new_game_play_result_path(@game, params[:play_id]), notice:
  end

  def select_opponent
    @general_challenges = @play.challenges.where(opponent: nil)
    @opponent = @game.characters.find(params[:opponent_id])
    @opponent_challenges = @play.challenges.where(opponent: @opponent)
  end

  private

    def set_play
      @play = current_user.plays.find(params[:play_id])
    end

    def play_result_params
      params.require(:result_form).permit(:play_id, :opponent_id, :result, :comment, challenges: {})
    end
end
