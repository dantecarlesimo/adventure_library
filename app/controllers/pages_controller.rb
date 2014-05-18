class PagesController < ApplicationController
  include PagesHelper

  before_action :load_adventure
   # before_action :load_page

  def show
    @page = @adventure.pages.find params[:id]
  end

  def new
    @page = @adventure.pages.new
  end

  def create
      new_page = @adventure.pages.new(page_params)
      # new_page.text +=" [[see the end|end]]"
      if new_page.save
        redirect_to new_adventure_page_path
      else
        render :new
      end
  end


  private 
    def page_params
      params.require(:page).permit(:name, :text, :adventure_id)
    end

    def load_adventure
      @adventure = Adventure.find params[:adventure_id]
      redirect_to root_path if @adventure.blank?
    end

    #  def load_page
    #    @page = @adventure.pages.find params[:id]
    #    redirect_to root_path if @page.blank?
    # end
end
