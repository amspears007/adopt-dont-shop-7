require "rails_helper"

RSpec.describe "application show page", type: :feature do
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

