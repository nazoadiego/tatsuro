class DownloadSongListAudio
  def initialize(
    url,
    get_video_description = GetVideoDescription.new,
    get_song_list_from_description = GetSongListFromDescription.new,
    download_audio_job = DownloadVideoAudioJob
  )
    @url = url
    @get_video_description = get_video_description
    @get_song_list_from_description = get_song_list_from_description
    @download_audio_job = download_audio_job
  end

  def run(description_text = nil)
    description = description_text || fetch_description
    download_audio_from_song_list(description)
  end

  private

  def fetch_description
    @get_video_description.run(@url)
  end

  def download_audio_from_song_list(description)
    song_list = @get_song_list_from_description.run(description)
    song_list.each do |song|
      download_song_audio(song[:start_time], song[:end_time], song[:title])
    end
  end

  def download_song_audio(start_time, end_time, title)
    @download_audio_job.perform_async(@url, start_time, end_time, title)
  end
end
