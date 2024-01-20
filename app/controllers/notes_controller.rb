class NotesController < BaseController
  def show
    @note = Note.find_or_initialize_by(user: current_user, game: @game)
  end
end
