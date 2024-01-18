class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_title

  private

    def set_title
      @title = Title.where("UPPER(abbreviation) = ?", params[:game_title].upcase).first
    end
end
