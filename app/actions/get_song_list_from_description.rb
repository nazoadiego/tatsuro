class GetSongListFromDescription
  def run(description)
    lines = description.split("\n").map!(&:strip)
    song_lines = select_song_lines(lines)
    p song_lines
    songs = parse_songs(song_lines)
  end

  private

  def parse_songs(lines)
    songs = lines.each_cons(2).map do |current_song, next_song|
      timestamp, title = parse_song(current_song)
      next_timestamp = parse_song(next_song).first

      { start_time: timestamp, end_time: next_timestamp, title: title }
    end

    last_timestamp, title = parse_song(lines.last)
    songs << { start_time: last_timestamp, end_time: nil, title: title }

    songs
  end

  def select_song_lines(lines)
    first_song_index = lines.index { |line| line.include?('00:') }
    last_song_index = lines.rindex { |line| line.match?(/^\d{1,2}:\d{2}/)}

    lines[first_song_index..last_song_index]
  end

  def parse_song(song_line)
    song_line.split(' ', 2)
  end
end