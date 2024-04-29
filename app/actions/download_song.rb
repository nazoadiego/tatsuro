class DownloadSong
  def initialize(download_audio_job = DownloadVideoAudioJob)
    @download_audio_job = download_audio_job
  end

  def run(url, start_time, end_time, title)
    job_id = @download_audio_job.perform_async(url, start_time, end_time, title)
    key = url + start_time
    Rails.cache.write(key, job_id)
  end
end