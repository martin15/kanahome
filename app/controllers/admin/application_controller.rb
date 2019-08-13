class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_action :require_admin_login

  def require_admin_login
     if current_user.nil?
       flash[:alert] = "Only Admin are permitted to access this page"
       redirect_to login_path
       return
     else
       return current_user
    end
  end
end
