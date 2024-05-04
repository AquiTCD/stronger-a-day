class Plays::ResultsController < BaseController
  before_action :set_play

  def new
    @general_challenges = @play.challenges.where(opponent: nil).order(:id)
    @opponents = @game.characters.order(:kana)
    results = @play.results.pluck(:result)
    @win_count = results.count("win")
    @lose_count = results.count("lose")
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
    @opponent_challenges = @play.challenges.where(opponent: @opponent).order(:id)
    @show_tutorial = current_user.tutorial?("#{controller_name}-new")
  end

  private

    def set_play
      @play = current_user.plays.find(params[:play_id])
    end

    def play_result_params
      params.require(:result_form).permit(:play_id, :opponent_id, :match_result, :comment, challenges: {})
    end
end
