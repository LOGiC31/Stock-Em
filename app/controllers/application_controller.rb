# frozen_string_literal: true

# Primary controller for the application.  Processes logins and first launches.
class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = (User.find_by(id: session[:user_id]) if session[:user_id])
  end

  def logged_in?
    current_user
  end

  def require_login
    return if logged_in?

    redirect_to welcome_path, alert: 'You must be logged in to access this section.'
  end
end
