class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  rescue ActiveRecord::RecordNotFound
    # Handle the case where the user is no longer in the database
    session[:user_id] = nil
    nil
  end

  def logged_in?
    # current_user returns @current_user,
    #   which is not nil (truthy) only if session[:user_id] is a valid user id
    current_user
  end

  def require_login
    # redirect to the welcome page unless user is logged in
    unless logged_in?
      redirect_to welcome_path, alert: 'You must be logged in to access this section.'
    end
  end
end