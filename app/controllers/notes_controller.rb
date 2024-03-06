class NotesController < BaseController
  def update
    if @note.update(content: params[:note][:content])
      flash.now[:success] = "クイックメモを保存しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
