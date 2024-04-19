class DownloadTracklistAudio
  def run(url, description_text)
    description = description_text || GetVideoDescription.new.run(url)
    tracklist = GetSongListFromDescription.new.run(description)
    tracklist.each do |song|
      DownloadVideoAudioJob.perform_async(url, song[:start_time], song[:end_time], song[:title])
    end
  end
end