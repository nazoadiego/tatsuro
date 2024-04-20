class NoDescriptionFoundError < StandardError
  def message
    "No description found"
  end
end