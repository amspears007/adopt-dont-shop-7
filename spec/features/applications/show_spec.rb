require "rails_helper"

RSpec.describe "application show page", type: :feature do
  # 1. Application Show Page
  
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"\
  before(:each) do
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
end

