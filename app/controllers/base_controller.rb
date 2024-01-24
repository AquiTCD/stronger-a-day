class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game

  private

    def set_game
      word = params[:abbreviation] || params[:game_abbreviation]
      @game = Game.where("UPPER(abbreviation) = ?", word.upcase).first
    end
end
