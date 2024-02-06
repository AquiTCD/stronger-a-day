class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :set_note
  before_action :set_notifications, only: [:show, :index, :new, :edit]

  private

    def set_game
      word = params[:abbreviation] || params[:game_abbreviation]
      @game = Game.where("UPPER(abbreviation) = ?", word.upcase).first
    end

    def set_note
      @note = current_user.notes.find_or_initialize_by(game: @game)
    end

    def set_notifications
      @notifications =
        Notification.
          where("released_at IS NULL OR released_at <= ?", Time.current).
          where("released_at IS NULL OR released_at >= ?", current_user.created_at).
          where("closed_at IS NULL OR closed_at > ?", Time.current).
          order(released_at: :desc).
          where.not(id: current_user.notifications.select(:notification_id))
    end
end
