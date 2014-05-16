class AdventuresController < ApplicationController
  
  def index
    @adventures = Adventure.all

    # respond_to do |f|
    #   f.html
      # f.json { render json: {adventures: @adventures.as_json (
                            # execpt: [:id, :library_id],
                            # include: {:pages => {except: :id}})}}
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
    redirect_to root_path
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  private

    def adventure_params
      params.require(:adventure).permit(:title, :author, :guid, :library_id)
    end
end
