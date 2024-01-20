module ApplicationHelper
  def turbo_stream_flash
    turbo_stream.update "flash", partial: "application/flash"
  end
end
