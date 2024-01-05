class ApplicationController < ActionController::Base
  before_action :load_settings
  def authenticate_admin!
    authenticate_user!
    unless(current_user.admin)
      flash[:alert] = 'Unauthorized access'
      redirect_to root_url
    end
  end
  def load_settings
    @settings = Setting.find_or_create_by(id: 1)
  end
end
