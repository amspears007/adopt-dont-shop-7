require "rails_helper"

RSpec.describe "Admin Application show page", type: :feature do
  before(:each)do
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_3.pets.create(name: "Draco", breed: "bat dog", age: 5, adoptable: true)
    @pet_2 = @shelter_3.pets.create(name: "Max", breed: "huge weiner dog", age: 9, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_4 = @shelter_3.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_5 = @shelter_3.pets.create(name: 'Okie', breed: 'black lab', age: 2, adoptable: true)


    @app_1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "In Progress")
    @app_2 = Application.create!(name: "Amy", street_address: "4321 Animal House St", city: "Denver", state: "CO", zipcode: 80238, description:"No more animals, I\"m too stressed from Turing!", status: "Pending")
    @app_3 = Application.create!(name: "Janet", street_address: "1111 Woofers Dr", city: "Denver", state: "CO", zipcode: 83673, description: "Okie Bokie is my favorite!", status: "In Progress")

    @pet_application_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_1.id)
    @pet_application_2 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_2.id)
    @pet_application_3 = PetApplication.create!(application_id: @app_1.id, pet_id: @pet_3.id)
    @pet_application_4 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_1.id)
    @pet_application_5 = PetApplication.create!(application_id: @app_2.id, pet_id: @pet_2.id)
    @pet_application_6 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_1.id)
    @pet_application_7 = PetApplication.create!(application_id: @app_3.id, pet_id: @pet_5.id)

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

  describe "US13 When I visit the Admin Application Show Page, I see a button to reject the application for that specific pet" do
    describe "When I click that button, then I am taken back to the Admin Application Show Page" do
      it "will not display the approve button next to the pet but will display an indicator next to the pet that they have been approved" do

        expect(page).to have_button("Reject Application for #{@pet_1.name}")
        click_button("Reject Application for #{@pet_1.name}")
        expect(current_path).to eq("/admin/applications/#{@app_3.id}")
        
        expect(page).to have_content("#{@pet_1.name} Rejected")
        expect(page).to_not have_button("Reject Application for #{@pet_1.name}")
      end
    end

#     As a visitor
# When there are two applications in the system for the same pet
# When I visit the admin application show page for one of the applications
# And I approve or reject the pet for that application
# When I visit the other application's admin show page
# Then I do not see that the pet has been accepted or rejected for that application
# And instead I see buttons to approve or reject the pet for this specific application
    describe "US14 Two applications in the system for the same pet" do
      it "I approve or reject the pet for that application then I visit the other application's admin show page. I do not see that the pet has been accepted or rejected for that application instead I see buttons to approve or reject the pet for this specific application" do
        visit "/admin/applications/#{@app_3.id}"
      
        expect(page).to have_button ("Approve Application for #{@pet_5.name}")
        expect(page).to have_button ("Reject Application for #{@pet_5.name}")
        expect(page).to have_button ("Approve Application for #{@pet_1.name}")
        expect(page).to have_button ("Reject Application for #{@pet_1.name}")

        click_button("Approve Application for #{@pet_1.name}")
        expect(current_path).to eq( "/admin/applications/#{@app_3.id}")
        expect(page).to have_content("Pet: #{@pet_1.name} Approved")

        visit "/admin/applications/#{@app_1.id}"

        expect(page).to have_button ("Approve Application for #{@pet_1.name}")
        expect(page).to have_button ("Reject Application for #{@pet_1.name}")
        expect(page).to have_button ("Approve Application for #{@pet_2.name}")
        expect(page).to have_button ("Reject Application for #{@pet_2.name}")

        click_button("Reject Application for #{@pet_1.name}")
        expect(current_path).to eq( "/admin/applications/#{@app_1.id}")
        expect(page).to have_content("Pet: #{@pet_1.name} Rejected")        
      end
    end
  end
end