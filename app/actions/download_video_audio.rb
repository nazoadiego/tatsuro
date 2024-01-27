class DownloadVideoAudio
  def initialize(youtube_dl: YoutubeDL)
    @youtube_dl = youtube_dl
  end

  def run(url)
    state = @youtube_dl.download(url, extract_audio: true, audio_format: 'mp3', audio_quality: 0)
    state = EventRunner.run(state)
    state.call
  end
end

class EventRunner
  def run(state)
    state.on_progress do |state:, line:|
      puts "Progress: #{state.progress}%"
    end
    .on_error do |state:, line:|
      puts "Error: #{state.error}"
    end
    .on_complete do |state:, line:|
      puts "Complete: #{state.destination}"
    end
  end
end