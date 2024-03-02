class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :set_note
  before_action :set_notifications, only: [:show, :index, :new, :edit]
  before_action :set_tutorial, only: [:show, :index, :new, :edit]

  private

    def set_game
      word = params[:abbreviation] || params[:game_abbreviation]
      @game = Game.where("UPPER(abbreviation) = ?", word.upcase).includes(:characters).first
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

    def set_tutorial
      # sessionにあれば表示しない
      if session.dig(:tutorial, controller_name, action_name) == "disable"
        @show_tutorial = false
        return
      end
      # DBになければ表示する
      if current_user.tutorial?("#{controller_name}-#{action_name}")
        @show_tutorial = true
        return
      end

      # sessionにはなくDBにだけある場合、sessionに保存
      hash = { controller_name => { action_name => "disable" } }
      if session[:tutorial]
        session[:tutorial].merge!(hash)
      else
        session[:tutorial] = hash
      end
      @show_tutorial = false
    end
end
