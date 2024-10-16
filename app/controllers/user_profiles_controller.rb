# frozen_string_literal: true

# This controller is used for anything profile-related, such as viewing a profile or editing yours.
class UserProfilesController < ApplicationController
  # before_action :set_user_profile, only: %i[show edit update destroy]

  # GET /user_profiles or /user_profiles.json
  def index
    @user_profile = User.where(email: @current_user.email)
  end

  # GET /user_profiles/1 or /user_profiles/1.json
  def show; end

  # # GET /user_profiles/new
  # def new
  #   @user_profile = User.new
  # end

  # GET /user_profiles/1/edit
  def edit; end
  # # GET /user_profiles/1/edit
  # def edit
  # end

  # POST /user_profiles or /user_profiles.json
  # def create
  #   @user_profile = User.new(user_profile_params)

  #   respond_to do |format|
  #     if @user_profile.save
  #       format.html { redirect_to @user_profile, notice: "User profile was successfully created." }
  #       format.json { render :show, status: :created, location: @user_profile }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @user_profile.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /user_profiles/1 or /user_profiles/1.json
  # def update
  #   respond_to do |format|
  #     if @user_profile.update(user_profile_params)
  #       format.html { redirect_to @user_profile, notice: "User profile was successfully updated." }
  #       format.json { render :show, status: :ok, location: @user_profile }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @user_profile.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /user_profiles/1 or /user_profiles/1.json
  # def destroy
  #   @user_profile.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to user_profiles_path, status: :see_other, notice: "User profile destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_user_profile
  #     @user_profile = User.find(params[:id])
  #   end

  #   # Only allow a list of trusted parameters through.
  #   def user_profile_params
  #     params.require(:user_profile).permit(:user_id, :name, :uin, :email, :contact_no, :role, :details, :auth_level)
  #   end
end