# frozen_string_literal: true

# Similar to user profiles, just defines a way to showcase a profile.
class UsersController < ApplicationController
  def show
    @current_user = User.find(params[:id])
  end

  def update
    @current_user = User.find(params[:id])

    respond_to do |format|
      if @current_user.update(user_params)
        format.html { redirect_to user_profiles_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @current_user }
      # else
      #   format.html { render :show, status: :unprocessable_entity }
      #   format.json { render json: @current_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :uin, :email, :contact_no, :role, :details)
  end
end

