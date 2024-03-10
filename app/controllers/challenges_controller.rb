class ChallengesController < BaseController # rubocop:disable Metrics/ClassLength
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :start]

  def index # rubocop:disable Metrics/AbcSize
    @show_tutorial = current_user.challenges.where(game: @game).size <= 3

    challenges = current_user.challenges.where(game: @game).includes(:character, :opponent)
    challenges = challenges.where(character_id: [nil, params[:character_id]]) if params[:character_id].present?
    challenges = challenges.where(opponent_id: [nil, params[:opponent_id]]) if params[:opponent_id].present?
    @challenges =
      challenges.not_achieved.
        order(Arel.sql("character_id IS NOT NULL, character_id ASC")).
        order(Arel.sql("opponent_id IS NOT NULL, opponent_id ASC")).
        order(:id)
    @challenge = Challenge.new(user: current_user, game: @game)
    @characters = current_user.selectable_characters(@game)
    @opponents = @game.characters

    @achieved_challenges = challenges.achieved.order(achieved_at: :desc)

    @filters = { character_id: params[:character_id], opponent_id: params[:opponent_id] }
  end

  def show
  end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    challenge = Challenge.new(
      user: current_user,
      game: @game,
      topic: challenge_params[:topic],
      character_id: challenge_params[:character_id],
      opponent_id: challenge_params[:opponent_id],
      public: challenge_params[:public],
    )
    if challenge.save
      @characters = current_user.selectable_characters(@game)
      @opponents = @game.characters
      challenges = current_user.challenges.where(game: @game).includes(:character, :opponent)
      challenges = challenges.where(character_id: [nil, filters[:character_id]]) if filters[:character_id].present?
      challenges = challenges.where(opponent_id: [nil, filters[:opponent_id]]) if filters[:opponent_id].present?
      @challenges =
        challenges.not_achieved.
          order(Arel.sql("character_id IS NOT NULL, character_id ASC")).
          order(Arel.sql("opponent_id IS NOT NULL, opponent_id ASC")).
          order(:id)
      if current_user.keep_selection
        @selected_character_id = challenge_params[:character_id]
        @selected_opponent_id = challenge_params[:opponent_id]
      end
      flash.now[:success] = "チャレンジを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def add
    @challenge = Challenge.new(
      user: current_user,
      game: @game,
      topic: challenge_params[:topic],
      character_id: challenge_params[:character_id],
      opponent_id: challenge_params[:opponent_id],
      public: challenge_params[:public],
    )
    if @challenge.save
      flash.now[:success] = "チャレンジを追加しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @characters = current_user.selectable_characters(@game)
    @opponents = @game.characters
    @filters = { character_id: params[:character_id], opponent_id: params[:opponent_id] }
  end

  def update
    if @challenge.update(challenge_params)
      challenges = current_user.challenges.where(game: @game).includes(:character, :opponent)
      challenges = challenges.where(character_id: [nil, filters[:character_id]]) if filters[:character_id].present?
      challenges = challenges.where(opponent_id: [nil, filters[:opponent_id]]) if filters[:opponent_id].present?
      @challenges =
        challenges.not_achieved.
          order(Arel.sql("character_id IS NOT NULL, character_id ASC")).
          order(Arel.sql("opponent_id IS NOT NULL, opponent_id ASC")).
          order(:id)
      flash.now[:success] = "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def start
    @challenge.toggle(:selected)
    if @challenge.save
      redirect_to game_challenge_path(@game, @challenge)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @challenge.destroy
      flash.now.alert = "チャレンジを削除しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def copy_sample
    user = User.system
    user.challenges.where(game: @game).each do |challenge|
      challenge.copy_to(current_user)
    end
    flash.now[:success] = "サンプルチャレンジを追加しました"
    redirect_to game_challenges_path(@game)
  end

  private

    def challenge_params
      params.require(:challenge).permit(:topic, :character_id, :opponent_id, :public)
    end

    def filters
      @filters ||= params.require(:filters).permit(:character_id, :opponent_id)
    end

    def set_challenge
      @challenge = Challenge.find(params[:id])
    end
end
