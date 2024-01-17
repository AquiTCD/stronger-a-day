class OAuthAuthenticator
  include Interactor

  # 認証データに対応するSNS_authが存在するか確認し、なければ新規作成。
  # すでにUserがついていればあるものを返す。
  # Userがなければ新規で作りつつSNS_authとひもづける
  #
  # @param [Hash] authentication hash
  #
  # @return [User]
  #
  def call
    validate_provider!
    find_or_initialize_auth
    fine_or_create_user_by_auth

    context
  end

  private

    def validate_provider!
      return if User::Authentication::PROVIDERS.map(&:to_s).include?(context.provider)

      context.fail!(message: "authenticate_user.failure")
    end

    def find_or_initialize_auth
      auth = User::Authentication.find_or_initialize_by(
        provider: context.provider,
        uid: context.uid,
      ) do |authentication|
        convert_attrs_by(authentication)
      end
      context.authentication = auth
    end

    def convert_attrs_by(auth)
      case context.provider
      when "twitter2"
        auth.username = context.info.username
        auth.display_name = context.info.name
        auth.email = context.info.email
        auth.url = context.info.urls.Twitter
        auth.image_url = context.info.image
      else
        context.fail!(message: "authenticate_user.failure")
      end
    end

    def fine_or_create_user_by_auth
      if context.authentication.user.blank?
        # ない場合は新規で作る
        ActiveRecord::Base.transaction do
          user = build_valid_user
          user.save!
          context.authentication.user = user
          context.authentication.save!
        end
      end

      context.user = context.authentication.user
    end

    def build_valid_user(suffix = nil)
      user = User.new(
        name: "#{context.authentication.username}_#{suffix}",
        display_name: "#{context.authentication.display_name}_#{suffix}",
      )
      return user if user.valid?

      if user.errors.details[:name].any? { |detail| detail[:error] == :taken }
        build_valid_user(rand(99))
      else
        context.fail!(message: "authenticate_user.failure")
      end
    end
end
