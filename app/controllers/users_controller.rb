# frozen_string_literal: true

# Similar to user profiles, just defines a way to showcase a profile.
class UsersController < ApplicationController
  def show
    @current_user = User.find(params[:id])
  end
end
