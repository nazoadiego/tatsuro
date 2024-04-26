require 'rails_helper'

RSpec.describe DownloadSong do
  let(:download_audio_job) { class_double("DownloadVideoAudioJob") }
  let(:download_song) { described_class.new(download_audio_job) }
  let(:url) { 'https://example.com/song.mp3' }
  let(:start_time) { '0:00' }
  let(:end_time) { '3:30' }
  let(:title ) { 'Example Song' }

  describe '#run' do
    it 'calls perform_async on DownloadVideoAudioJob with the provided arguments' do
      expect(download_audio_job).to receive(:perform_async).with(url, start_time, end_time, title)

      download_song.run(url, start_time, end_time, title)
    end
  end
end