# frozen_string_literal: true

# This controller is used for anything profile-related, such as viewing a profile or editing yours.
class UserProfilesController < ApplicationController
  before_action :set_user_profile, only: %i[show edit update destroy]

  # GET /user_profiles or /user_profiles.json
  def index
    @user_profile = current_user
    @editing = false
  end

  def show; end

  def edit
    @editing = true
    render :index
  end

  def update
    # respond_to do |format|
    #   if @user_profile.update(user_profile_params)
    #     format.html { redirect_to user_profiles_path }
    #     format.json { render :show, status: :ok, location: @user_profile }
    #   else
    #     format.html { render :index, status: :unprocessable_entity }
    #     format.json { render json: @user_profile.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    # @user_profile.destroy!

    # respond_to do |format|
    #   format.html { redirect_to user_profiles_path, status: :see_other, notice: "User profile destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private

  def set_user_profile
    @user_profile = current_user
  end

  def user_profile_params
    # params.require(:user).permit(:first_name, :last_name, :uin, :email, :contact_no, :role, :details)
  end
end
