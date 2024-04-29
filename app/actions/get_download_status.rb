class GetDownloadStatus
  def run(url:, start_time:)
    key = url + start_time
    job_id = Rails.cache.fetch(key)
    Sidekiq::Status::status(job_id)
  end
end