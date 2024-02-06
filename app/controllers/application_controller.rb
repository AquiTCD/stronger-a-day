class ApplicationController < ActionController::Base
  include ErrorHandleable
  before_action :set_notifications, only: [:show, :index]

  # NOTE: Only for maintenance mode
  # before_action :in_maintenance

  def after_sign_in_path_for(resource)
    home_path || root_path
  end

  private

    def in_maintenance
      raise ErrorHandleable::InMaintenance
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
