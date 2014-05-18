class AdventuresController < ApplicationController
  include PagesHelper
  def index
    @library = Library.new
    @adventures = Adventure.all
    local_adventures = Adventure.where(:library_id => nil)
    respond_to do |f|
      f.html
      f.json { render :json => {"adventures"=>local_adventures.as_json(except: [:id, :library_id], include: {pages:{except: [:id, :adventure_id]}})}}

      #http://localhost:3000/adventures.json

      # f.json { render json: {adventures: @adventures.as_json (
      #                       execpt: [:id, :library_id],
      #                       include: {:pages => {except: :id}})}}
    end
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new (adventure_params)
    @adventure.guid = SecureRandom.urlsafe_base64(10)
    # binding.pry
    # @adventurs.library_id = nil
    @adventure.save
    redirect_to new_adventure_page_path(@adventure)
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  private

    def adventure_params
      params.require(:adventure).permit(:title, :author, :guid, :library_id)
    end
end
