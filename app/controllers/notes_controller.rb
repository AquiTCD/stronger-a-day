class NotesController < BaseController
  before_action :note

  def new
    # binding.irb
  end

  def show
    # binding.irb
  end

  def create
    @note.content = params[:note][:content]
    @note.save
  end

  def edit
  end

  def update
    @note.update(content: params[:note][:content])
    redirect_to note_path(@game, @note)
  end

  def add_line
    if line_param.present?
      br = @note.content ? "\n" : ""
      @note.update(content: "#{@note.content}#{br}- #{line_param}")
    end
  end

  private

    def note
      @note ||= current_user.notes.find_or_initialize_by(game: @game) do |note|
        note.content = ""
      end
    end

    def line_param
      ps = params.permit(:line)
      ps[:line].strip
    end
end
