class NotAYoutubeUrlError < StandardError
  def message
    "Not a youtube url"
  end
end
