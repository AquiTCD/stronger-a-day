class Users::TutorialsController < ApplicationController
  def create
    User::Tutorial.create(user: current_user, page: params[:page])
  end
end
