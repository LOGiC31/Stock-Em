# frozen_string_literal: true

# app/controllers/concerns/event_logger.rb
module EventLogger
  extend ActiveSupport::Concern

  def log_event(item_id, event_type, details, associated_user_id, location = nil)
    Event.create(
      event_id: SecureRandom.uuid,
      item_id:,
      event_type:,
      associated_user_id:,
      location:,
      details:
    )
  end
end
