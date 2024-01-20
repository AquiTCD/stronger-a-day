class NotesController < BaseController
  def show
    @note = current_user.notes.find_or_initialize_by(game: @game) do |note|
      note.content = ""
    end
  end

  def create
    @note = current_user.notes.find_or_initialize_by(game: @game) do |note|
      note.content = params[:note][:content]
    end
    @note.save
  end

  def edit
    @note = current_user.notes.find_by(game: @game)
  end

  def update
    @note = Note.find_by(user: current_user, game: @game)
    @note.update(content: params[:note][:content])
    redirect_to note_path(@game, @note)
  end
end
