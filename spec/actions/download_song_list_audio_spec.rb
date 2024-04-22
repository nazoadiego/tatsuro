require 'rails_helper'

RSpec.describe DownloadSongListAudio do
  let(:url) { "https://www.youtube.com/watch?v=video_id" }
  let(:description_no_songs) { "Mocked description text" }
  let(:description_with_songs) { 
    "00:00 Stay With Me - Miki Matsubara
    05:44 Lady Sunshine - Anri" 
  }
  let(:songs) { [
      { title: "Stay With Me - Miki Matsubara", start_time: "00:00", end_time: "05:44"},
      { title: "Lady Sunshine - Anri", start_time: "05:44", end_time: nil}
    ] 
  }
  let(:get_video_description) { double("GetVideoDescription") }
  let(:get_song_list_from_description) { double("GetSongListFromDescription") }
  let(:download_audio_job) { double("DownloadVideoAudioJob") }

  describe "#run" do
    context "when description text is not provided" do
      context "and the description has no songs" do
        it "fetches from the url" do
          expect(get_video_description).to receive(:run).and_return(description_no_songs)
          expect(get_song_list_from_description).to receive(:run).with(description_no_songs).and_return([])
          expect(download_audio_job).not_to receive(:perform_async)
  
          action = DownloadSongListAudio.new(url, get_video_description, get_song_list_from_description, download_audio_job)
          action.run
        end
      end

      context "and the description has songs" do
        it "fetches from the url" do
          expect(get_video_description).to receive(:run).and_return(description_with_songs)
          expect(get_song_list_from_description).to receive(:run).with(description_with_songs).and_return(songs)
          expect(download_audio_job).to receive(:perform_async).twice

          action = DownloadSongListAudio.new(url, get_video_description, get_song_list_from_description, download_audio_job)
          action.run
        end
      end
    end

    context "when a description text is provided" do
      context "and the description has songs" do
        it "does not fetch from url and downloads audio based on the description text" do
          expect(get_video_description).not_to receive(:run)
          expect(get_song_list_from_description).to receive(:run).with(description_no_songs).and_return(songs)
          expect(download_audio_job).to receive(:perform_async).twice

          action = DownloadSongListAudio.new(url, get_video_description, get_song_list_from_description, download_audio_job)
          action.run(description_no_songs)
        end
      end

      context "and the description has no songs" do
        it "does not fetch from url and downloads audio based on the description text" do
          expect(get_video_description).not_to receive(:run)
          expect(get_song_list_from_description).to receive(:run).with(description_with_songs).and_return([])
          expect(download_audio_job).not_to receive(:perform_async)

          action = DownloadSongListAudio.new(url, get_video_description, get_song_list_from_description, download_audio_job)
          action.run(description_with_songs)
        end
      end
    end
  end
end