class GetVideoDescription
  def run(url)
    raise NotAYoutubeUrlError unless youtube_url?(url)

    description = fetch_description(url)

    raise NoDescriptionFoundError if description.empty?

    description
  end

  private

  def youtube_url?(url)
    url.include?('youtube')
  end

  def fetch_description(url)
    command = "youtube-dl --skip-download --get-description #{url}"
    %x{#{command}}
  end
end
