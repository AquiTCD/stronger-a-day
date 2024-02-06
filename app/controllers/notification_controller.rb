class NotificationController < ApplicationController
  skip_before_action :set_notifications

  def confirm
    notification = Notification.find(params[:id])
    if User::Notification.create(user: current_user, notification:)
      render turbo_stream: [turbo_stream.remove(notification)]
    end
  end
end
