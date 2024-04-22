class DownloadVideoAudio
  def initialize(youtube_dlp: YoutubeDL, event_logger: EventLogger.new)
    @youtube_dlp = youtube_dlp
    @event_logger = event_logger
  end

  def run(url, start_time, end_time, title)
    options = {
      check_certificate: false,
      extract_audio: true,
      audio_format: 'mp3',
      audio_quality: 0,
      download_sections: download_sections(start_time, end_time),
      output: output_path(title)
    }

    state = @youtube_dlp.download(url, **options)
    @event_logger.run(state)
  end

  def run_dlp(url, start_time, end_time, title)
    p "#{start_time} - #{end_time} - #{title} started"
    command = "yt-dlp --no-check-certificate -x --audio-format mp3 --audio-quality 0 --download-sections '*#{start_time}-#{end_time}' -o '#{Rails.root}/tmp/#{title}' #{url}"
    %x{#{command}}
  end

  private

  def download_sections(start_time, end_time)
    return "*#{start_time}" if end_time.nil?

    "*#{start_time}-#{end_time}"
  end

  def output_path(title)
    "#{Rails.root}/tmp/downloads/#{title}"
  end
end