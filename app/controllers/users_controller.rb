class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by!(name: params[:name])

    played_character_ids = @user.plays.where.associated(:results).distinct.pluck(:character_id)
    @games = Game.joins(:characters).where(characters: { id: played_character_ids })
    @challenges = @user.challenges.where(game: @games, public: true).includes(:character, :opponent)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(update_params)
      redirect_to edit_me_path, flash: { success: "ユーザー情報を更新しました" }
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def update_params
      params.require(:user).permit(:name, :display_name)
    end
end
