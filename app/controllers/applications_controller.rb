class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new
   
  end

  def create
    application = Application.new(application_params)
    if application.save
    redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: Please fill in all fields"
    end
  end

  def update
    @application = Application.find(params[:id])
    @added_a_pet = Pet.find_by(name: params[:search])
    PetApplication.create!(application_id: @application.id, pet_id: @added_a_pet.id)
    redirect_to "/applications/#{@application.id}"
    # require 'pry'; binding.pry
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :pet_names, :status)
  end
end