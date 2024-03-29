class GamesController < BaseController
  skip_before_action :set_game, only: [:index]

  def index
    @games = Game.all
  end

  def show
    play_statuses = current_user.plays.where(character: @game.characters).where.associated(:results).distinct.pluck(:status)
    challenge_achieves = current_user.challenges.where(game: @game).pluck(:achieved_at)

    @all_challenging_count = challenge_achieves.size
    @achieved_challenge_count = challenge_achieves.compact.size
    @playing = play_statuses.select { |s| s == "in_progress" }.present?
    @to_review_count = play_statuses.select { |s| s == "finished" }.size
  end
end
