require "rails_helper"

RSpec.describe "application show page", type: :feature do
  before(:each) do
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 7, breed: "sphynx", name: "Bare-y Manilow", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "domestic pig", name: "Babe", shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 4, breed: "chihuahua", name: "Elle", shelter_id: @shelter.id)
    @app1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", pet_names: "Draco", status: "In Progress")
  end
  describe "As a visitor, when I visit the application show page" do
    it "it shows the application attributes" do
      visit "/applications/#{@app1.id}"

      expect(page).to have_content(@app1.name)
      expect(page).to have_content(@app1.street_address)
      expect(page).to have_content(@app1.city)
      expect(page).to have_content(@app1.state)
      expect(page).to have_content(@app1.zipcode)
      expect(page).to have_content(@app1.description)
      expect(page).to have_content(@app1.pet_names)
      expect(page).to have_content(@app1.status)
    end
  end

#   As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search

  describe "US4 It has a button to add a pet to the application" do
    it "I see a section on the page to 'Add a Pet to this application" do
      visit "/applications/#{@app1.id}"

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_button("Search")
      expect(page).to have_content("In Progress")

      fill_in "Search", with: "Elle"
      click_on("Search")

      expect(page).to have_content(@pet_3.name)
      expect(page).to_not have_content(@pet_1.name)
      expect(current_path).to eq("/applications/#{@app1.id}")

      fill_in "Search", with: "Babe"
      click_on("Search")

      expect(page).to have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_1.name)

    end
  end
end

