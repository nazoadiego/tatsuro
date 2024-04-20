class GetVideoDescription
  def run(url)
    raise NotAYoutubeUrlError unless url.include?('youtube')

    command = "youtube-dl --skip-download --get-description #{url}"
    description = %x{#{command}}

    raise NoDescriptionFoundError if description.empty?

    description
  end
end
