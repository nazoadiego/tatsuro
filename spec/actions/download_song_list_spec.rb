require 'rails_helper'

RSpec.describe DownloadSongList do
  let(:download_song_double) { double("DownloadSong") }
  let(:url) {'https://example.com/playlist'}
  let(:song_list) {
    [
      { start_time: '0:00', end_time: '3:30', title: 'Song 1' },
      { start_time: '3:30', end_time: '7:00', title: 'Song 2' }
    ]
  }

  describe '#run' do
    it 'calls run on DownloadSong for each song in the list' do
      download_song_list = DownloadSongList.new(url, download_song_double)

      song_list.each do |song|
        expect(download_song_double).to receive(:run).with(url, song[:start_time], song[:end_time], song[:title])
      end

      download_song_list.run(song_list)
    end
  end
end
