require "rails_helper"

RSpec.describe "US10 Admin Shelter Index", type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter3.pets.create(name: 'Draco', breed: 'bat dog', age: 5, adoptable: true)
    @pet_2 = @shelter2.pets.create(name: 'Max', breed: 'huge weiner dog', age: 9, adoptable: true)
    @pet_3 = @shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_4 = @shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_5 = @shelter2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    
    @app1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "In Progress")
    @app2 = Application.create!(name: "Amy", street_address: '4321 Animal House St', city: 'Denver', state: 'CO', zipcode: 80238, description:"No more animals, I'm too stressed from Turing!", status: "In Progress")
    @app3 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "Pending")

    @pet1_application = PetApplication.create!(application_id: @app1.id, pet_id: @pet_1.id)
    @pet2_application = PetApplication.create!(application_id: @app1.id, pet_id: @pet_2.id)
    @pet3_application = PetApplication.create!(application_id: @app1.id, pet_id: @pet_4.id)
    @pet4_application = PetApplication.create!(application_id: @app2.id, pet_id: @pet_2.id)
    @pet5_application = PetApplication.create!(application_id: @app3.id, pet_id: @pet_2.id)
      end

  it "As an admin lists all Shelters in the system listed in reverse alphabetical order by name" do
    visit "/admin/shelters"

    expect(@shelter2.name).to appear_before(@shelter3.name)
    expect(@shelter3.name).to appear_before(@shelter1.name)
    expect(@shelter2.name).to appear_before(@shelter1.name)
  end

  describe "US11 I see a section for 'Shelters with Pending Applications'" do
    it "displays a section of the name of every shelter that has a pending application" do
      visit "/admin/shelters"

      within("#pending_applications") do
        expect(page).to have_content("Shelters with Pending Applications")
        expect(page).to have_content(@shelter2.name)
      end
    end
  end
end