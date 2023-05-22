class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet= Pet.find_by(params[:pet_id])
  end

  def update
    @approved_application = Application.find(params[:id])
    @approved_pet= Pet.find_by(params[:pet_id])
    
    # if params[:status] == "Approved"
    #   application.update(status: params[:status])
    #   require 'pry'; binding.pry
    # else
    #   pet_app = PetApplication.create!(application_id: application.id, pet_id: @approved_pet.id)
    # end
      redirect_to "/admin/applications/#{application.id}"
  end
end

