class UsersController < ApplicationController
  before_action :authenticate_user!

  def show # rubocop:disable Metrics/AbcSize
    @user = User.find_by!(name: params[:name])

    played_character_ids = @user.plays.where.associated(:results).distinct.pluck(:character_id)
    played_character_ids += @user.challenges.pluck(:character_id)
    @fav_characters = @user.favorite_characters.includes(character: :game)
    played_character_ids += @fav_characters.pluck(:character_id)
    played_character_ids = played_character_ids.uniq.compact
    @playing_games = Game.joins(:characters).where(characters: { id: played_character_ids }).distinct
    @selected_game = @playing_games.find_by(id: params[:game_id]) || @playing_games.first

    case params[:type]
    when "trainings"
      @trainings =
        @user.trainings.where(game: @selected_game, public: true).includes(:character, :recipe).order("RANDOM()").limit(10)
    when "recipes"
      @recipes =
        @user.recipes.where(game: @selected_game, public: true).includes(:character, :situations, recipe_situations: :situation).order("RANDOM()").limit(10)
    else
      challenges = @user.challenges.where(game: @selected_game, public: true).includes(:character, :opponent)
      @achieved_challenges = challenges.where.not(achieved_at: nil).order("RANDOM()").limit(10)
      @in_progress_challenges = challenges.where(achieved_at: nil).order("RANDOM()").limit(10)
    end
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
