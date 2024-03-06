module ApplicationHelper
  require "commonmarker"
  def turbo_stream_flash
    turbo_stream.update "flash", partial: "shared/flash"
  end

  def md_to_html(text = "")
    html = Commonmarker.to_html(text)
    raw(html)
  end

  def alert_classes_for(flash_type)
    {
      notice: "bg-gray-800 border-gray-400 text-white",
      success: "bg-gray-800 border-green-400 text-green-200",
      error: "bg-gray-800 border-red-500 text-red-400",
      alert: "bg-gray-800 border-yellow-500 text-yellow-300"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
