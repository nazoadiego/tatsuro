# frozen_string_literal: true

class AlertComponent < ViewComponent::Base
  def initialize(type:, message:)
    @type = type
    @message = message
  end
end
