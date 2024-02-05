class ApplicationController < ActionController::Base
  include ErrorHandleable

  # NOTE: Only for maintenance mode
  before_action :in_maintenance

  def after_sign_in_path_for(resource)
    home_path || root_path
  end

  private

    def in_maintenance
      raise ErrorHandleable::InMaintenance
    end
end
