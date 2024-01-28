class GamesController < BaseController
  def show
    daily_statuses = current_user.dailies.where(character: @game.characters).where.associated(:daily_results).pluck(:status)
    challenge_achieves = current_user.challenges.where(game: @game).pluck(:achieved_at)

    @all_challenging_count = challenge_achieves.size
    @achieved_challenge_count = challenge_achieves.compact.size
    @playing = daily_statuses.select { |s| s == "in_progress" }.present?
    @to_review_count = daily_statuses.select { |s| s == "finished" }.size
  end
end
