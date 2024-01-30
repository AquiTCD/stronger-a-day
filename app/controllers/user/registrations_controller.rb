class User::RegistrationsController < Devise::RegistrationsController
  # GET /user/registration/sign_up

  # POST /user/registration/
  def create
    ActiveRecord::Base.transaction do
      super do |user|
        user.authentications.create(session["devise.authentication"])
      end
    end
    # TODO: バリデーションエラー時の処理
  end

  private

    def sign_up_params
      params.permit(:name, :display_name)
    end
end
