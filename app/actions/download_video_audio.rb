class DownloadVideoAudio
  def initialize(youtube_dlp: YoutubeDL)
    @youtube_dl = youtube_dlp
  end

  def run(url)
    state = @youtube_dlp.download(url, extract_audio: true, audio_format: 'mp3', audio_quality: 0)
    state = EventLogger.new.run(state)
    state.call
  end
end
