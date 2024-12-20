# frozen_string_literal: true

# Tests logins upon first launch.
class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    return unless logged_in?

    redirect_to user_path(@current_user), notice: 'Welcome, back!'
  end
end
