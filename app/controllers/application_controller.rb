class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def current_user
    return @current_user if defined?(@current_user)
  
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    current_user
  end

  def require_login
    unless logged_in?
      redirect_to welcome_path, alert: 'You must be logged in to access this section.'
    end
  end
end