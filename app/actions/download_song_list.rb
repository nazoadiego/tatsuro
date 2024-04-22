class DownloadSongList
  def initialize(url, download_song = DownloadSong.new)
    @url = url
    @download_song = download_song
  end

  def run(song_list)
    song_list.each do |song|
      @download_song.run(@url, song[:start_time], song[:end_time], song[:title])
    end
  end
end
