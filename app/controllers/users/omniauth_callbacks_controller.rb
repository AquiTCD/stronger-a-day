# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
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
        redirect_to sign_up_path
      end
    end

    def after_omniauth_failure_path_for(scope)
      root_path
    end

    def after_sign_in_path_for(resource)
      home_path
    end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
