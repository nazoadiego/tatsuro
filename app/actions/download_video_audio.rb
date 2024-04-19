OUTPUT_FILEPATH = "#{Rails.root}/song.mp3"

class DownloadVideoAudio
  def initialize(youtube_dlp: YoutubeDL)
    @youtube_dl = youtube_dlp
  end

  def run_gem(url, start_time, end_time, title)
    options = {
      check_certificate: false,
      extract_audio: true,
      audio_format: 'mp3',
      audio_quality: 0,
      download_sections: download_sections(start_time, end_time),
      output: "#{Rails.root}/tmp/#{title}"
    }

    state = @youtube_dl.download(url, **options)
    EventLogger.new.run(state)
  end

  def run_dlp(url, start_time, end_time, title)
    p "#{start_time} - #{end_time} - #{title} started"
    command = "yt-dlp --no-check-certificate -x --audio-format mp3 --audio-quality 0 --download-sections '*#{start_time}-#{end_time}' -o '#{Rails.root}/tmp/#{title}' #{url}"
    song = %x{#{command}}
  end

  def download_sections(start_time, end_time)
    return "*#{start_time}" if end_time.nil?

    "*#{start_time}-#{end_time}"
  end
end
