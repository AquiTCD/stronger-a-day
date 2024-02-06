class Users::NotificationsController < ApplicationController
  def index
    notifications =
      Notification.
        where("released_at IS NULL OR released_at <= ?", Time.current).
        where("released_at IS NULL OR released_at >= ?", current_user.created_at).
        where("closed_at IS NULL OR closed_at > ?", Time.current)
    @user_notifications = notifications.sort_by { |n| n.released_at || n.created_at }.reverse
  end

  def confirm
    notification = Notification.find(params[:id])
    if User::Notification.create(user: current_user, notification:)
      render turbo_stream: [turbo_stream.remove(notification)]
    end
  end
end
