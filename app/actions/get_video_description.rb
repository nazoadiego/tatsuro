EXAMPLE_URL = "https://www.youtube.com/watch?v=OycgifzTHgk"
class GetVideoDescription
  class NoDescriptionFoundError < StandardError
    def message
      "No description found"
    end
  end

  class NotAYoutubeUrlError < StandardError
    def message
      "Not a youtube url"
    end
  end

  def run(url = EXAMPLE_URL)
    raise NotAYoutubeUrlError unless url.include?('youtube')

    command = "youtube-dl --skip-download --get-description #{url}"
    description = %x{#{command}}

    raise NoDescriptionFoundError if description.empty?

    description
  end
end
