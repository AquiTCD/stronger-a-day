class BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :set_note

  private

    def set_game
      word = params[:abbreviation] || params[:game_abbreviation]
      @game = Game.where("UPPER(abbreviation) = ?", word.upcase).first
    end

    def set_note
      @note = current_user.notes.find_or_initialize_by(game: @game) do |note|
        note.content = ""
      end
    end
end
