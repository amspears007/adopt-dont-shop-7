class ApplicationsController < ApplicationController
  def show
    @applications = Application.find(params[:id])
  end

  def new
    
  end
end