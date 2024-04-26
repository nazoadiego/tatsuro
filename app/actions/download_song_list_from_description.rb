class DownloadSongListFromDescription
  def initialize(
    url,
    download_song_list = DownloadSongList.new(url),
    get_video_description = GetVideoDescription.new,
    get_song_list_from_description = GetSongListFromDescription.new
  )

    @url = url
    @get_video_description = get_video_description
    @get_song_list_from_description = get_song_list_from_description
    @download_song_list = download_song_list
  end

  def run(description_text = nil)
    description = description_text || fetch_description
    song_list = @get_song_list_from_description.run(description)
    @download_song_list.run(song_list)
  end

  private

  def fetch_description
    @get_video_description.run(@url)
  end
end
