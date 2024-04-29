# frozen_string_literal: true

class SongCardComponent < ViewComponent::Base
  def initialize(title:, start_time:, end_time:, url:, status:)
    @title = title
    @start_time = start_time
    @end_time = end_time
    @url = url
    @status = status
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

  def download_status_style
    return "bg-emerald-700" if @status == :complete
    return "bg-sky-800" if @status == :working
    return "bg-yellow-600" if @status == :queued

    "bg-zinc-600"
  end
end
