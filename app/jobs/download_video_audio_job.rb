# require 'sidekiq'
 
class DownloadVideoAudioJob
  include Sidekiq::Job

  def perform(url, start_time, end_time, title, action: DownloadVideoAudio.new)
    action.run_dlp(url, start_time, end_time, title)
  end
end