require 'rails_helper'

RSpec.describe DownloadSongListFromDescription do
  let(:url) { 'https://example.com/playlist' }
  let(:song_list) {
    [
      { start_time: '0:00', end_time: '3:30', title: 'Song 1' },
      { start_time: '3:30', end_time: '7:00', title: 'Song 2' }
    ]
  }
  let(:download_song_list_double) { instance_double(DownloadSongList, run: nil) }
  let(:get_song_list_from_description_double) { instance_double(GetSongListFromDescription, run: nil) }
  let(:get_video_description_double) { instance_double(GetVideoDescription, run: description_text) }

  describe '#run' do
    context 'when description text is provided' do
      let(:description_text) { "Song 1: [0:00 - 3:30]\nSong 2: [3:30 - 7:00]" }

      it 'uses the provided description text' do
        expect(get_video_description_double).not_to receive(:run)
        expect(get_song_list_from_description_double).to receive(:run).with(description_text).and_return(song_list)
        expect(download_song_list_double).to receive(:run)

        download_song_list_from_description = described_class.new(url, download_song_list_double, get_video_description_double, get_song_list_from_description_double)
        download_song_list_from_description.run(description_text)
      end
    end

    context 'when description text is not provided' do
      let(:description_text) { "Song 1: [0:00 - 3:30]\nSong 2: [3:30 - 7:00]" }

      it 'fetches a description from the url' do
        expect(get_video_description_double).to receive(:run).and_return(description_text)
        expect(get_song_list_from_description_double).to receive(:run).with(description_text).and_return(song_list)
        expect(download_song_list_double).to receive(:run)

        download_song_list_from_description = described_class.new(url, download_song_list_double, get_video_description_double, get_song_list_from_description_double)
        download_song_list_from_description.run
      end
    end
  end
end
