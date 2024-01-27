class GetVideoDescription
  def initialize(youtube_dl_client: YoutubeDL)
    @youtube_dl_client = youtube_dl_client
  end

  def run(url)
    state = @youtube_dl_client.download(url, skip_download: true, get_description: true)
    .on_progress do |state:, line:|
      puts "Progress: #{state.progress}%"
    end
    .on_error do |state:, line:|
      puts "Error: #{state.error}"
    end
    .on_complete do |state:, line:|
      puts "Complete: #{state.destination}"
    end
    .call
  end
end