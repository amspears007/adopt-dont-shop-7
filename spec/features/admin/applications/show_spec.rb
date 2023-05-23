require "rails_helper"

RSpec.describe "Admin Application show page", type: :feature do
  before(:each)do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_3.pets.create(name: "Draco", breed: "bat dog", age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create(name: "Max", breed: "huge weiner dog", age: 9, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_5 = @shelter_2.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

    @app_1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "In Progress")
    @app_2 = Application.create!(name: "Amy", street_address: "4321 Animal House St", city: "Denver", state: "CO", zipcode: 80238, description:"No more animals, I\"m too stressed from Turing!", status: "Pending")
    @app_3 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "Pending")

    @pet_application_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    @pet_application_2 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_1.id)
    @pet_application_3 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_1.id)
    @pet_application_4 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_2.id)

    visit "/admin/applications/#{@app_3.id}"
  end

  describe "US12 When I visit the Admin Application Show Page, I see a button to approve the application for that specific pet" do  
    describe "When I click that button, then I am taken back to the Admin Application Show Page" do
      it "will not display the approve button next to the pet but will display an indicator next to the pet that they have been approved" do

        expect(page).to have_button("Approve Application for #{@pet_1.name}")
        click_button("Approve Application for #{@pet_1.name}")
        
        expect(current_path).to eq("/admin/applications/#{@app_3.id}")

        expect(page).to have_content("#{@pet_1.name} Approved")
        expect(page).to_not have_button("Approve Application for #{@pet_1.name}")
      end
    end
  end
end