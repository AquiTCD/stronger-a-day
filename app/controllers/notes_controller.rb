class NotesController < BaseController
  def show
  end

  def create
    @note.content = params[:note][:content]
    @note.save
  end

  def edit
  end

  def update
    @note.update(content: params[:note][:content])
    redirect_to game_note_path(@game)
  end
end
