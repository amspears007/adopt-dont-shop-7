class Admin::SheltersController < ApplicationController
  def index
    @ordered_shelters = Shelter.sort_shelter_name_z_a
  end
end