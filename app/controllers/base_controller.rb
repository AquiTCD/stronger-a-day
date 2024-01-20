class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game

  private

    def set_game
      @game = Game.where("UPPER(abbreviation) = ?", params[:game_title].upcase).first
    end
end
