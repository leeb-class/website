class DocumentsController < ApplicationController
    before_action :authenticate_user!, except: [:url]
    
    def index
      @documents = Document.all
    end
  
    def new
      @document = Document.new
    end
  
    def url
      if params[:url]!=nil
        if (params[:format]!=nil and params[:format]!='')
          params[:url]+=".#{params[:format]}"
        end
        puts "##### #{params[:url]}"
        @document = Document.find_by_url(params[:url])
        if @document == nil
          flash[:alert] = "Unknown document, sorry"
          redirect_to root_path #unknown page
          return
        end
        #protect private documents from download
        if((@document.public == false) and (not user_signed_in?))
          flash[:alert] = "Login to view this document"
          redirect_to root_path and return
        end
      else
        flash[:alert] = "No document specified"
        redirect_to root_path #unknown page
        return
      end
      #redirect_to @document.attachment_url
      redirect_to rails_blob_url(@document.file)
      return true    
    end
    
    def create
      @document = Document.new(document_params)
      if(@document.name=="")
        @document.name = @document.file.filename
      end
      @document.url = @document.file.filename.sanitized
      @document.public = params[:document][:public]
      if @document.save
        redirect_to documents_path, notice: "Successfully added document"
        return
      end
      render :new  
    end
  
    def destroy
      @document = Document.find(params[:id])
      @document.destroy
      redirect_to documents_path, notice: "Successfully removed document"
    end
    
    private
      def document_params
        params.require(:document).permit(:name, :file)
      end
  end
  