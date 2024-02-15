class ApplicationController < ActionController::Base
  include ErrorHandleable

  before_action :sentry_set_user, if: :user_signed_in?

  # NOTE: Only for maintenance mode
  # before_action :in_maintenance

  def after_sign_in_path_for(resource)
    home_path || root_path
  end

  private

    def sentry_set_user
      Sentry.set_user(id: current_user.id)
    end

    def in_maintenance
      raise ErrorHandleable::InMaintenance
    end
end
