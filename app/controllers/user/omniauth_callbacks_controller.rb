class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter2
    callback_from :twitter2
  end

  private

    def callback_from(provider)
      result = OmniauthAuthentication.call(request.env["omniauth.auth"])
      return redirect_to root_path, alert: t(result.message) if result.failure?

      @user = result.authentication.user
      if @user
        sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:success, :success, kind: provider.to_s.capitalize) if is_navigational_format?
      else
        session["devise.authentication"] = result.authentication.attributes
        redirect_to new_user_registration_path
      end
    end

    def after_omniauth_failure_path_for(scope)
      root_path
    end

    def after_sign_in_path_for(resource)
      home_path
    end
end
