class User::SessionsController < Devise::SessionsController
  # only_for_devlopment
  def login
    user = User.first
    sign_in_and_redirect user
  end

  def after_sign_in_path_for(resource)
    if resource.registered?
      root_path
    else
      new_user_registration_path
    end
  end
end
