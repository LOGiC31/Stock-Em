# app/controllers/concerns/event_logger.rb
module EventLogger
  extend ActiveSupport::Concern

  def log_event(item_id, event_type, details, associated_user_id, location = nil)
    Event.create(
      event_id: SecureRandom.uuid,
      item_id: item_id,
      event_type: event_type,
      associated_user_id: associated_user_id,
      location: location,
      details: details
    )
  end
end
