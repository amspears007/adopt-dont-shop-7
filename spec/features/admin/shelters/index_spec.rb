require "rails_helper"

RSpec.describe "US10 Admin Shelter Index", type: :feature do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_3.pets.create(name: 'Draco', breed: 'bat dog', age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create(name: 'Max', breed: 'huge weiner dog', age: 9, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_5 = @shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    
    @app_1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "In Progress")
    @app_2 = Application.create!(name: "Amy", street_address: '4321 Animal House St', city: 'Denver', state: 'CO', zipcode: 80238, description:"No more animals, I'm too stressed from Turing!", status: "In Progress")
    @app_3 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "Pending")

    @pet_application_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    @pet_application_2 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_2.id)
    @pet_application_3 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_4.id)
    @pet_application_4 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_2.id)
    @pet_application_5 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_2.id)
    @pet_application_6 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_1.id)

    visit "/admin/shelters"

  end

  it "will display all shelters in reverse alphabetical order" do

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
    expect(@shelter_2.name).to appear_before(@shelter_1.name)

    expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    expect(@shelter_3.name).to_not appear_before(@shelter_2.name)

  end

  describe "US11 I see a section for 'Shelters with Pending Applications'" do
    it "displays a section of the name of every shelter that has a pending application" do

      within("#pending_applications") do
        expect(page).to have_content("Shelters with Pending Applications")
        expect(page).to have_content(@shelter_2.name)
        expect(page).to have_content(@shelter_3.name)
      end

    end
  end
end