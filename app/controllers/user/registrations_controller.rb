class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # GET /sign_up
  # def new; end

  # POST /sign_up
  def create
    ActiveRecord::Base.transaction do
      super do |user|
        user.authentications.create!(session["devise.authentication"])
      end
    end
  rescue ActiveRecord::RecordNotSaved
    render :new, status: :unprocessable_entity
  end

  private

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :display_name])
    end
end
