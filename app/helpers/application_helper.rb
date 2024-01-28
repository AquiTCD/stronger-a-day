module ApplicationHelper
  require "commonmarker"
  def turbo_stream_flash
    turbo_stream.update "flash", partial: "shared/flash"
  end

  def md_to_html(text)
    html = Commonmarker.to_html(text)
    raw(html)
  end

  def alert_classes_for(flash_type)
    {
      notice: "bg-gray-700 border-l-4 border-gray-400 text-white",
      success: "bg-green-700 border-l-4 border-green-400 text-white",
      error: "bg-red-700 border-l-4 border-red-400 text-white",
      alert: "bg-yellow-700 border-l-4 border-yellow-400 text-white"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
