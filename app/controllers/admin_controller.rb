class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_admin!

  def index
    add_breadcrumb "Home", admin_root_path
    add_breadcrumb "Dashboard"
  end

end
