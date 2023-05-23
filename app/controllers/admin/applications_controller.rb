class Admin::ApplicationsController < ApplicationController
  def show    
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
  end
  
  def update
    approved_application = PetApplication.find_by(application_id: params[:id], pet_id: params[:pet_id])
    approved_pet= Pet.find(params[:pet_id])
    if params[:status] == "Approved"
      approved_application.update(status: params[:status])
    else
      pet_app = PetApplication.create!(application_id: approved_application.id, pet_id: approved_pet.id)
    end
      redirect_to "/admin/applications/#{params[:id]}"
  end
end

