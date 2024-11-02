# frozen_string_literal: true

# Similar to user profiles, just defines a way to showcase a profile.
class UsersController < ApplicationController
  skip_before_action :require_login, only: [:update_auth_level]
  skip_before_action :require_login, only: [:update_auth_level]
  def show
    @current_user = User.find(params[:id])
  end

  def update
    @current_user = User.find(params[:id])

    respond_to do |format|
      if @current_user.update(user_params)
        format.html { redirect_to user_profiles_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @current_user }
        # else
        #   format.html { render :show, status: :unprocessable_entity }
        #   format.json { render json: @current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_auth_level
    user = User.find(params[:id])

    if params[:auth_level] < '3' && user.update(auth_level: params[:auth_level], role: user.role)
      render json: { auth_level: user.auth_level, role: user.role }
    else
      render json: { status: 'error', message: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :uin, :email, :contact_no, :role, :details)
  end
end
