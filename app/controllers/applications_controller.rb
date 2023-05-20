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
    # require 'pry'; binding.pry
    application = Application.find(params[:id])
    added_pet = Pet.find_by(name: params[:search])

    if params[:status] == "Pending"
      application.update(status: params[:status], description: params[:description])
    else
      pet_app = PetApplication.create!(application_id: application.id, pet_id: added_pet.id)
    end
      redirect_to "/applications/#{application.id}"
    # PetApplication.create!(application_id: application.id, pet_id: @added_pet.id)
    # redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
  end
end