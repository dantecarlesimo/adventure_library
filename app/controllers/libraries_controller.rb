class LibrariesController < ApplicationController
 # get /libraries.json 

  def index
    @libraries = Library.all
    respond_to do |format|
      # @libraries.each do |library|
        format.json { render json: {"libraries" => @libraries.as_json(except: :id)} }
      # end
    end 
  end

  def create
    @library = Library.new(library_params)
    if @library.save
      AdventuresWorker.perform_async(@library.id)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
    def library_params
      params.require(:library).permit(:url)
    end

end
