require 'rails_helper'

RSpec.describe DownloadVideoAudio do
  let(:youtube_dlp) { class_double(YoutubeDL) }
  let(:event_logger) { instance_double(EventLogger) }

  subject { described_class.new(youtube_dlp: youtube_dlp, event_logger: event_logger) }

  describe '#run' do
    let(:url) { 'https://www.youtube.com/watch?v=video_id' }
    let(:start_time) { '00:00' }
    let(:end_time) { '04:50' }
    let(:title) { 'Sample Title' }
    let(:options) do
      {
        check_certificate: false,
        extract_audio: true,
        audio_format: 'mp3',
        audio_quality: 0,
        download_sections: "*#{start_time}-#{end_time}",
        output: "#{Rails.root}/tmp/downloads/#{title}"
      }
    end
    let(:state) { 'downloaded' }

    before do
      allow(youtube_dlp).to receive(:download).with(url, **options).and_return(state)
      allow(event_logger).to receive(:run)
    end

    it 'downloads the audio and logs the event' do
      expect(youtube_dlp).to receive(:download).with(url, **options)
      expect(event_logger).to receive(:run).with(state)

      subject.run(url, start_time, end_time, title)
    end
  end
end
