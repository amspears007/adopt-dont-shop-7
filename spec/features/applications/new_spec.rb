require "rails_helper"

RSpec.describe "Application new page", type: :feature do
  describe "US2  I am taken to the new application page where I see a form When I fill in    this form with attributes" do
    before(:each) do
      @app1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state:     "CO", zipcode: 83673, description: "I love pets!", pet_names: "Draco", status: "In Progress")
    end

    it "I am taken to the new application's show page I see my Name, address information, and description of why I would make a good home And I see an indicator that this application is 'In Progress" do

      visit "/applications/new"

      fill_in 'Name', with: 'Sarah'
      fill_in 'Street address', with: "1234 Dog Lane"
      fill_in "City", with: "Denver"
      fill_in 'State', with: 'CO'
      fill_in 'Zipcode', with: 83673
      fill_in 'Description', with: "I love pets!"
    
      fill_in 'pet_names', with: 'Draco'

      click_on "Submit"

      expected_id = Application.last.id
      expect(current_path).to eq("/applications/#{expected_id}")
      expect(page).to have_content('Sarah')
      expect(page).to have_content("1234 Dog Lane")
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('I love pets')
      expect(page).to have_content('Draco')
      expect(page).to have_content('In Progress')
    end

    it "I see a message that I must fill in those fields" do
      # User Story 3
      visit "/applications/new"

      fill_in 'Name', with: ''
      fill_in 'Street address', with: "1234 Dog Lane"
      fill_in "City", with: "Denver"
      fill_in 'State', with: 'CO'
      fill_in 'Zipcode', with: 83673
      fill_in 'Description', with: "I love pets!"
      fill_in 'pet_names', with: 'Draco'

      click_on "Submit"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Error: Please fill in all fields")
    end
  end
end