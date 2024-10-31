# frozen_string_literal: true

# Contains logic for web pages which display item(s)
class EventsController < ApplicationController
  
  def publish_event # rubocop:disable Metrics/AbcSize
    details = ""
    time_string = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    if params[:evtype] == "Checkout"
      details = "Checked out to "

      unless params[:teams].blank?
        details += params[:teams].to_s + " in "
      end

      details += params[:location].to_s + " "
      details += "on " + time_string + " "
      details += "with " + params[:professor].to_s + " as the responsible professor"

      unless params[:comments].blank?
        details += ".  " + params[:comments].to_s
      end
    else
      details = "Checked in on " + time_string + " "
      details += "to " + params[:professor].to_s + " "
      details += "with the new location being " + params[:location].to_s

      unless params[:comments].blank?
        details += ".  " + params[:comments].to_s
      end
    end

    Event.create!({ event_id: '', item_id: params[:itemid], event_type: params[:evtype], associated_student_id: session[:user_id],
                    associated_user_id: session[:user_id], location: params[:location], created_at: Time.now,
                    updated_at: Time.now, details: details })

    item = Item.find(params[:itemid])
    item.update!(currently_available: ! item.currently_available)

    respond_to do |format|
      format.html { redirect_to item_path(item) }
      format.json { head :no_content }
    end
  end

  # creating a new event
  def new
    @itemid = params[:itemid]

    item = Item.find(params[:itemid])
    @evtype = "Checkout"
    if item.currently_available == false
      @evtype = "Checkin"
    end

  end
  
end