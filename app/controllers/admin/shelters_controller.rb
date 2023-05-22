class Admin::SheltersController < ApplicationController
  def index
    @ordered_shelters = Shelter.sort_shelter_name_z_a
    @pending = Shelter.pending_applications
  end
end