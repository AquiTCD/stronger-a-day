class DailyResultsController < BaseController
  before_action :set_daily

  def new
    @general_challenges = @daily.challenges.where(opponent: nil)
    @opponents = @game.characters
    results = @daily.daily_results
    @win_count = results.sum(:win_count)
    @lose_count = results.sum(:lose_count)
  end

  def create
    result_form = ResultForm.initialize_by_params(daily_result_params)
    result_form.save_result!

    redirect_to new_daily_daily_result_path(@game, params[:daily_id])
  end

  def select_opponent
    @general_challenges = @daily.challenges.where(opponent: nil)
    @opponent = @game.characters.find(params[:opponent_id])
    @opponent_challenges = @daily.challenges.where(opponent: @opponent)
  end

  private

    def set_daily
      @daily = current_user.dailies.find(params[:daily_id])
    end

    def daily_result_params
      params.require(:result_form).permit(:daily_id, :opponent_id, :result, challenges: {})
    end
end
