# frozen_string_literal: true

class SongCardComponent < ViewComponent::Base
  def initialize(title:, start_time:, end_time:, url:)
    @title = title
    @start_time = start_time
    @end_time = end_time
    @url = url
  end

  def timestamp
    return @start_time if @end_time.nil?

    "#{@start_time} - #{@end_time}"
  end

  def song_url
    "#{@url}&t=#{start_time_in_seconds}s"
  end

  def start_time_in_seconds
    @start_time.split(':').map(&:to_i).inject(0) { |a, b| a * 60 + b }
  end
end
