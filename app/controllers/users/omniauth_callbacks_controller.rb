# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: %i[steam]

  def twitter2
    callback_from :twitter2
  end

  def discord
    callback_from :discord
  end

  def steam
    callback_from :steam
  end

  private

    def callback_from(provider) # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity, Metrics/MethodLength
      result = OmniauthAuthentication.call(request.env["omniauth.auth"])
      return redirect_to root_path, alert: t(result.message) if result.failure?

      @user = result.user
      if @user
        # 既にUserと紐づいている = ログイン
        if current_user
          # NOTE: 他のアカウントと連携済みの場合はエラー
          return redirect_to edit_me_path, flash: { error: "そのアカウントとは連携できません" } if current_user != @user

          # NOTE: なぜかログイン済みの場合はいったんトップに戻す
          return redirect_to root_path, flash: { error: "不明なエラー" }
        end

        # 認証時に更新
        result.authentication.save! if result.authentication.persisted?
        sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:success, :success, kind: provider.to_s.capitalize) if is_navigational_format?
      else
        # 既にUserと紐づいてない = 初回アカウント登録 or 既存アカウントに紐付け
        # NOTE: ログイン済みの場合は既存のUserに紐付ける
        if current_user
          result.authentication.user = current_user
          result.authentication.save!

          redirect_to edit_me_path, flash: { success: "#{provider.to_s.capitalize} ログイン連携を追加しました" }
        else
          session["devise.authentication"] = result.authentication.attributes
          redirect_to sign_up_path
        end
      end
    end

    def after_omniauth_failure_path_for(scope)
      root_path
    end

    def after_sign_in_path_for(resource)
      home_path
    end

  # You should configure your model like this:さい
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
