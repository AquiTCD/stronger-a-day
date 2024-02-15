class Users::TutorialsController < ApplicationController
  def create
    User::Tutorial.create(user: current_user, page: params[:page])
    page = params[:page].split("-")
    hash = { page[0] => { page[1] => "disable" } }
    if session[:tutorial]
      session[:tutorial].merge!(hash)
    else
      session[:tutorial] = hash
    end
  end
end
