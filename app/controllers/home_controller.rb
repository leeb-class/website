class HomeController < ApplicationController
    def index
    
      if params[:url]!=nil
        @page = Page.find_by_url(params[:url])
        if @page == nil
          flash[:alert] = "Unknown page, sorry"
          redirect_to root_path #unknown page
          return
        end
        unless (user_signed_in? or  @page.visible)
          flash[:alert] = "Unauthorized action"
          redirect_to root_path #not available to normal users
          return
        end
      else
        @page = Page.first
        # show the new page site if there are no pages
        redirect_to new_page_path and return if @page.nil?
      end
      @pages =  Page.order(order: :asc)
      if not user_signed_in?
        @pages.where!(visible: true)
      end
    end
  end
  