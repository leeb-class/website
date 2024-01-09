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
    @settings = {
      title: ENV['TITLE'],
      subtitle: ENV['SUBTITLE'],
      page_title: ENV['PAGE_TITLE']
    }
  end
end
