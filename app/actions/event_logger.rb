class EventLogger
  def run(state)
    state.on_progress do |state:, line:|
      puts "Progress: #{state.progress}%"
    end
    .on_error do |state:, line:|
      puts "Error: #{state.error}"
    end
    .on_complete do |state:, line:|
      puts "Complete: #{state.destination}"
    end
    .call
  end
end
