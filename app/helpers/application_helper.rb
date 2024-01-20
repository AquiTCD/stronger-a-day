module ApplicationHelper
  require "commonmarker"
  def turbo_stream_flash
    turbo_stream.update "flash", partial: "application/flash"
  end

  def md_to_html(text)
    html = Commonmarker.to_html(text)
    raw(html)
  end
end
