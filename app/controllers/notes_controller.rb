class NotesController < BaseController
  def show
    @note = Note.find_or_initialize_by(user: current_user, game: @game) do |note|
      note.content = ""
    end
  end

  def create
    @note = Note.find_or_initialize_by(user: current_user, game: @game) do |note|
      note.content = params[:note][:content]
    end
    @note.save
  end

  def update
    @note = Note.find_by(user: current_user, game: @game)
    @note.update(content: params[:note][:content])
  end
end
