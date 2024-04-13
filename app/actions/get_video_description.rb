EXAMPLE_URL = "https://www.youtube.com/watch?v=OycgifzTHgk"
class GetVideoDescription
  def run(url = EXAMPLE_URL)
    command = "youtube-dl --skip-download --get-description #{url}"
    description = %x{#{command}}

    # Split the description into lines
    lines = description.split("\n")

    # Find the index of the first line with a timestamp
    first_track_index = lines.index { |line| line.include?('00:') }

    # Find the index of the last line with a timestamp
    last_track_index = lines.rindex { |line| line.include?(':') }

    # Trim the lines to include only the tracks
    tracklist_lines = lines[first_track_index..last_track_index]

    # Process each trimmed line
    tracklist_lines.each do |line|
      # Split each line into timestamp, title, and track number
      timestamp, rest = line.split(' ', 2)
      track_number, title = rest.split('-', 2).map(&:strip)
      puts "#{timestamp}: #{track_number} - #{title}"
    end
  end
end
