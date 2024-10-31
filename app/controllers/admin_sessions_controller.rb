# frozen_string_literal: true

class AdminSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create dashboard destroy]

  def dashboard
    @users = User.all
  end

  def new
    # render new
  end

  def create
    admin = Admin.find_by(username: params[:username])
    puts admin.inspect
    if admin&.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_dashboard_path, notice: 'Logged in as admin successfully!'
    else
      flash[:alert] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to admin_login_path, notice: 'Logged out of admin'
  end
end
