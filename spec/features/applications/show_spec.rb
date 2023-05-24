require "rails_helper"

RSpec.describe "Application Show Page", type: :feature do
  before(:each) do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)
    @app_1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", pet_names: "Draco", status: "In Progress")
    @app_2 = Application.create!(name: "Amy", street_address: "4321 Animal House St", city: "Denver", state: "CO", zipcode: 80238, description:"No more animals, I\"m too stressed from Turing!", status: "Pending")
  end

  describe "US1 As a visitor, when I visit the application show page" do
    it "it shows the application attributes" do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_1.street_address)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.state)
      expect(page).to have_content(@app_1.zipcode)
      expect(page).to have_content(@app_1.description)
      expect(page).to have_content(@app_1.status)

      visit "/applications/#{@app_2.id}"

      expect(page).to have_content(@app_2.name)
      expect(page).to have_content(@app_2.street_address)
      expect(page).to have_content(@app_2.city)
      expect(page).to have_content(@app_2.state)
      expect(page).to have_content(@app_2.zipcode)
      expect(page).to have_content(@app_2.description)
      expect(page).to have_content(@app_2.status)

    end
  end

  describe "US4 When the application has not been submitted" do
    describe "I see a section on the page to 'Add a Pet to this Application' and I see an input where I can search for a Pets name" do
      it "can search for a pets name and when submitted it takes me back to the show page and it will display the pet under the search bar" do
        visit "/applications/#{@app_1.id}"
        expect(page).to have_content("In Progress")

        within("#add_pet-#{@app_1.id}") do
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_button("Submit")
      
          fill_in "Search", with: "Elle"
          click_on("Submit")

          expect(current_path).to eq("/applications/#{@app_1.id}")
          expect(page).to have_content(@pet_3.name)
          expect(page).to_not have_content(@pet_1.name)
        end

        fill_in "Search", with: "Babe"
        click_on("Submit")

        expect(page).to have_content(@pet_2.name)
        expect(page).to_not have_content(@pet_1.name)
      end
    end
  end

  describe "US5 I see a button to 'Adopt this Pet'" do
    it "takes me back to the app show page when I click that button and see the Pet listed" do
      visit "/applications/#{@app_1.id}"
      
      fill_in "Search", with: "Babe"
      click_on("Submit")

      expect(page).to have_content("Babe")
      expect(page).to have_button("Adopt this Pet")
      
      expect(current_path).to eq("/applications/#{@app_1.id}")
      click_button "Adopt this Pet"

      expect(current_path).to eq("/applications/#{@app_1.id}")
      expect(page).to have_content("Babe")
      expect(page).to_not have_button("Adopt this Pet")
    end
  end

  describe "US6 When I have added one or more pets to the application" do
    it "I see a section to submit my application and input to enter my description. I fill in the form and click submit I am rerouted back to the show page and the status has changed to 'pending' and I see the pets I want adopt and dont' see the pet search bar to adopt more" do
      visit "/applications/#{@app_1.id}"
      
      fill_in "Search", with: "Babe"
      click_on("Submit")
      expect(page).to have_content("Babe")
      click_button "Adopt this Pet"

      within("#submit_application-#{@app_1.id}") do
        expect(page).to have_content("Submit My Application")
        fill_in :description, with: "I love animals"
        click_button("Apply")
        
        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to_not have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Search")
      end
      
      expect(page).to have_content("Pending")
    end
  end

  describe "US7 I have not added any pets to the application" do
    it "will not display a section to submit my application until I add a pet" do
      visit "/applications/#{@app_1.id}"
      expect(page).to_not have_content("Submit My Application")
      expect(page).to_not have_content("Pet: Babe")
      expect(page).to_not have_content("Why I would make a good owner for these pet(s)")

      fill_in "Search", with: "Babe"
      click_on("Submit")
      expect(page).to have_content("Babe")
      click_button "Adopt this Pet"

      
      within("#submit_application-#{@app_1.id}") do
        expect(page).to have_content("Submit My Application")
        fill_in :description, with: "I love animals"
        click_button("Apply")
        
        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to_not have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Search")
      end
      expect(page).to have_content("Pending")
    end
  end

  describe "US8 I search for Pets by name" do
    it "allows me to seach for any pet whose name partially matches my search" do
      visit "/applications/#{@app_1.id}"

      fill_in "Search", with: "El"
      click_on("Submit")
      expect(page).to have_content("Elle")
      expect(page).to have_button("Adopt this Pet")

      fill_in "Search", with: "lle"
      click_on("Submit")
      expect(page).to have_content("Elle")
      expect(page).to have_button("Adopt this Pet")
    end

    it "allows me to seach for any pet whose regardless of case" do
      visit "/applications/#{@app_1.id}"

      fill_in "Search", with: "elle"
      click_on("Submit")
      expect(page).to have_content("Elle")
      expect(page).to have_button("Adopt this Pet")

      fill_in "Search", with: "ba"
      click_on("Submit")
      expect(page).to have_content("Babe")
      expect(page).to have_button("Adopt this Pet")
    end
  end
end