class GetSongListFromDescription
  def run(description)
    lines = select_lines(description)
    song_lines = select_song_lines(lines)
    songs = parse_songs(song_lines)
  end

  private

  def select_lines(description)
    description.split("\n").map!(&:strip)
  end

  def select_song_lines(lines)
    first_song_index = lines.index { |line| line.include?('00:') || line.include?('0:') }
    last_song_index = lines.rindex { |line| line.match?(/^\d{1,2}:\d{2}/)}

    lines[first_song_index..last_song_index].reject(&:empty?)
  end

  def parse_songs(lines)
    songs = lines.each_cons(2).map do |current_song, next_song|
      song = parse_song(current_song)
      next_song = parse_song(next_song)

      { start_time: song[:timestamp], 
      end_time: next_song[:timestamp], title: song[:title] }
    end

    last_song = parse_song(lines.last)
    songs << { start_time: last_song[:timestamp], end_time: nil, title: last_song[:title] }

    songs
  end

  def parse_song(song_line)
    timestamp, title = song_line.split(' ', 2)

    timestamp = remove_brackets(timestamp) if timestamp.match?(/\[.*\]/)

    { timestamp:, title: }
  end

  def remove_brackets(string)
    string.gsub(/[\[\]]/, '')
  end
end