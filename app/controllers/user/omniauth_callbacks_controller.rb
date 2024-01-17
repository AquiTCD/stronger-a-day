class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter2
    callback_from :twitter2
  end

  private

    def callback_from(provider)
      auth = request.env["omniauth.auth"]
      return redirect_to root_path unless auth

      result = OAuthAuthenticator.call(auth)

      return redirect_to root_path, alert: t(result.message) if result.failure?

      sign_in_and_redirect result.user
    end

    def after_omniauth_failure_path_for(scope)
      root_path
    end

    def after_sign_in_path_for(resource)
      if resource.registered?
        flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: provider.to_s.capitalize)
        root_path
      else
        new_user_registration_path
      end
    end
end
