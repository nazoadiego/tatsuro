class GetSongListFromDescription
  def run(description)
    lines = select_lines(description)
    song_lines = select_song_lines(lines)

    song_lines.present? ? parse_songs(song_lines) : []
  end

  private

  def select_lines(description)
    description.split("\n").map!(&:strip)
  end

  def select_song_lines(lines)
    first_song_index = lines.index { |line| line.include?('00:') || line.include?('0:') }
    last_song_index = lines.rindex { |line| line.match?(/\d{1,2}:\d{2}/)}

    # TODO: Handle test case too, [nil..nil] selects all
    return [] if first_song_index.nil? && last_song_index.nil?

    lines[first_song_index..last_song_index].reject(&:empty?)
  end

  def parse_songs(lines)
    songs = lines.each_cons(2).map do |current_song, next_song|
      song = parse_song(current_song)
      next_song = parse_song(next_song)

      { start_time: song[:timestamp], end_time: next_song[:timestamp], title: song[:title] }
    end

    last_song = parse_song(lines.last)
    songs << { start_time: last_song[:timestamp], end_time: nil, title: last_song[:title] }

    songs
  end

  def parse_song(song_line)
    song_line = remove_index_format(song_line)
    timestamp, title = song_line.split(' ', 2)

    timestamp = remove_brackets(timestamp)
    title = remove_dash(title)
    title = title.strip

    { timestamp:, title: }
  end

  def remove_brackets(string)
    # Brackets enclosing timestamps like [TIME_STAMP]
    string.gsub(/[\[\]]/, '')
  end

  def remove_dash(string)
    # Titles like TIME_STAMP - Song title
    string.gsub(/^-/, '')
  end

  def remove_index_format(string)
    # Start of line like 1), 2), 3)
    string.gsub(/^\d+\)/, '')
  end
end