class User::RegistrationsController < Devise::RegistrationsController
  # GET /user/registration/sign_up
  def new
    resource = current_user
    render :new, locals: { resource: }
  end

  # POST /user/registration/
  def create
    ActiveRecord::Base.transaction do
      user = current_user
      user.update!(
        name: sign_up_params[:name],
        display_name: sign_up_params[:display_name],
      )
      user.create_registration!(
        email: sign_up_params[:email],
      )
    end

    redirect_to root_path
  end

  private

    def sign_up_params
      params.permit(:name, :display_name, :email)
    end
end
