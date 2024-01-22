class DailiesController < BaseController
  def new
    @daily = current_user.dailies.new
    @characters = @game.characters
  end

  def create
    existed_dailies = current_user.dailies.where(character_id: daily_params[:character_id], tried_on: Date.today)
    round = existed_dailies.size + 1
    @daily = current_user.dailies.new(
      character_id: daily_params[:character_id],
      tried_on: Date.today,
      round:,
    )
    if @daily.save
      redirect_to new_daily_daily_challenge_path(@game, @daily)
    #   current_user.dailies.new(daily_params)
    else
      render :create, status: :unprocessable_entity
    end
  end

  private

    def daily_params
      params.permit(:character_id, :tried_on)
    end
end
