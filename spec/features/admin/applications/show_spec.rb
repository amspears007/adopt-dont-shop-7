# 12. Approving a Pet for Adoption

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
# ```
require "rails_helper"

RSpec.describe "Admin Application show page", type: :feature do
  before(:each)do
  @shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  @shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
  @shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  @pet_1 = @shelter3.pets.create(name: 'Draco', breed: 'bat dog', age: 5, adoptable: true)
  @pet_2 = @shelter2.pets.create(name: 'Max', breed: 'huge weiner dog', age: 9, adoptable: true)
  @pet_3 = @shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
  @pet_4 = @shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
  @pet_5 = @shelter2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)


  @app1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "In Progress")
  @app2 = Application.create!(name: "Amy", street_address: '4321 Animal House St', city: 'Denver', state: 'CO', zipcode: 80238, description:"No more animals, I'm too stressed from Turing!", status: "Pending")
  @app3 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "Pending")

  @pet1_application = PetApplication.create!(application_id: @app1.id, pet_id: @pet_1.id)
  @pet2_application = PetApplication.create!(application_id: @app2.id, pet_id: @pet_1.id)
  @pet3_application = PetApplication.create!(application_id: @app3.id, pet_id: @pet_1.id)
  @pet4_application = PetApplication.create!(application_id: @app2.id, pet_id: @pet_2.id)
end

  describe " US12 '/admin/applications/:id'  I see a button to approve the application for that specific pet" do
    it "I click that button Then I'm taken back to the admin application show page And next to the pet that I approved, I do not see a button to approve this pet And instead I see an indicator next to the pet that they have been approved" do
      visit "/admin/applications/#{@app3.id}"
      expect(page).to have_button("Approve Application for #{@pet_1.name}")
      click_button("Approve Application for #{@pet_1.name}")
      save_and_open_page
      # require 'pry'; binding.pry
      expect(current_path).to eq("/admin/applications/#{@app3.id}")

      expect(page).to have_content("#{@pet_1.name} Approved")
      expect(page).to_not have_button("Approve Application for #{@pet_1.name}")
    end
  end
end