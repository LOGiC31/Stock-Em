# app/controllers/admin/base_controller.rb
class Admin::BaseController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  before_action :require_admin

  private

  def require_admin
    redirect_to admin_login_path unless session[:admin_id]
  end
end
