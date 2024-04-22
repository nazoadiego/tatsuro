class DownloadSong
  def initialize(download_audio_job = DownloadVideoAudioJob)
    @download_audio_job = download_audio_job
  end

  def run(url, start_time, end_time, title)
    @download_audio_job.perform_async(url, start_time, end_time, title)
  end
end