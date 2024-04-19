class DownloadSongListAudio
  def run(url, description_text)
    description = description_text || GetVideoDescription.new.run(url)
    song_list = GetSongListFromDescription.new.run(description)
    song_list.each do |song|
      DownloadVideoAudioJob.perform_async(url, song[:start_time], song[:end_time], song[:title])
    end
  end
end