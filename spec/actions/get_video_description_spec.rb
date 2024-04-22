require 'rails_helper'

RSpec.describe GetVideoDescription do
  let(:get_video_description) { GetVideoDescription.new }

  context "with a valid YouTube URL" do
    let(:valid_url) { "https://www.youtube.com/watch?v=abc123" }
    let(:description) { "This is a YouTube video description." }

    it "returns the video description" do
      allow(get_video_description).to receive(:`).and_return(description)
      expect(get_video_description.run(valid_url)).to eq(description)
    end
  end

  context "with an invalid YouTube URL" do
    let(:invalid_url) { "https://example.com/video" }

    it "raises a NotAYoutubeUrlError" do
      # ` is equivalent to %x{#{command}}
      allow(get_video_description).to receive(:`).and_return("")
      expect { get_video_description.run(invalid_url) }.to raise_error(NotAYoutubeUrlError)
    end
  end

  context "with a YouTube URL with no description" do
    let(:no_description_url) { "https://www.youtube.com/watch?v=def456" }

    it "raises a NoDescriptionFoundError" do
      # ` is equivalent to %x{#{command}}
      allow(get_video_description).to receive(:`).and_return("")
      expect { get_video_description.run(no_description_url) }.to raise_error(NoDescriptionFoundError)
    end
  end
end