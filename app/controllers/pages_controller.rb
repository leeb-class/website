class PagesController < ApplicationController
    before_action :set_page, only: [:edit, :update, :destroy]
    before_action :authenticate_admin!, only: [:create, :destroy, :index]
    before_action :authenticate_user!
    
    # GET /pages
    # GET /pages.json
    def index
      @pages = Page.order(order: :asc).all
    end
  
    # GET /pages/new
    def new
      @page = Page.new
      if Page.count==0
        @page.order = 0
      else
        @page.order = Page.order(order: :asc).last.order+1
      end
    end
  
    # GET /pages/1/edit
    def edit
      #make sure the user has appropriate permissions
      unless @page.editable or current_user.admin?
        flash[:alert] = 'Unauthorized access'
        redirect_to root_url 
        return
      end
    end
  
    # POST /pages
    # POST /pages.json
    def create
      @page = Page.new(page_params)
      #create a valid and unique URL
      url = @page.title.parameterize
      base_url = url
      unique = false
      salt=0
      begin
        unique = true
        Page.find_each do |page|
          if page.url==url
            unique=false
            url=base_url+"-"+salt.to_s
            salt+=1
            break
          end
        end
      end while not unique
      @page.url = url
      respond_to do |format|
        if @page.save
          format.html { redirect_to pages_url, notice: 'Page was successfully created.' }
          format.json { render :index, status: :created, location: @page }
        else
          format.html { render :new }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /pages/1
    # PATCH/PUT /pages/1.json
    def update
      #make sure the user has appropriate permissions
      unless @page.editable or current_user.admin?
        flash[:alert] = 'Unauthorized access'
        redirect_to root_url 
        return
      end
      respond_to do |format|
        if @page.update(page_params)
          format.html { redirect_to "/page/"+@page.url, notice: 'Page was successfully updated.' }
          format.json { render :show, status: :ok, location: @page }
        else
          format.html { render :edit }
          format.json { render json: @page.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /pages/1
    # DELETE /pages/1.json
    def destroy
      @page.destroy
      respond_to do |format|
        format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_page
        @page = Page.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      # Never trust parameters from the scary internet, only allow the white list through.
      def page_params
        params.require(:page).permit(:title,:editable,:visible, :content, :order)
      end
      
     
  end
  