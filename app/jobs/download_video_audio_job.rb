class DownloadVideoAudioJob
  include Sidekiq::Job
  include Sidekiq::Status::Worker

  def perform(url, start_time, end_time, title, action: DownloadVideoAudio.new)
    action.run(url, start_time, end_time, title)
  end
end