require "rails_helper"

RSpec.describe "Application new page", type: :feature do
  before(:each) do
    @app1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state:     "CO", zipcode: 83673, description: "I love pets!", pet_names: "Draco", status: "In Progress")
  end

  describe "US2 Starting an Application" do
    describe "A link for 'Start an Application' will display. When clicked, it will rediect to New Application Page" do
      it "will display a from to fill out with Application form attrubutes and will be filled out correctly. An indicator will display that this application is 'In Progress'" do

        visit "/applications/new"

        fill_in "Name", with: "Sarah"
        fill_in "Street address", with: "1234 Dog Lane"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zipcode", with: 83673
        fill_in "Why would you make a good home for this pet(s)?", with: "I love pets!"

        click_on "Submit"

        expected_id = Application.last.id
        expect(current_path).to eq("/applications/#{expected_id}")
        expect(page).to have_content("Sarah")
        expect(page).to have_content("1234 Dog Lane")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_content("I love pets")
        expect(page).to have_content("In Progress")
      end

      it "US3 I see a message that I must fill in those fields after leaving a field blank" do
        visit "/applications/new"

        fill_in "Name", with: ""
        fill_in "Street address", with: "1234 Dog Lane"
        fill_in "City", with: "Denver"
        fill_in "State", with: "CO"
        fill_in "Zipcode", with: 83673
        fill_in "Why would you make a good home for this pet(s)?", with: "I love pets!"

        click_on "Submit"

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: Please Make Sure All Fields Are Filled In Correctly")
      end
    end
  end
end