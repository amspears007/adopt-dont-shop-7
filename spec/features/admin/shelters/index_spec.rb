# For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql

# 10. Admin Shelters Index

# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name
# ```
require "rails_helper"

RSpec.describe "Admin Shelter Index", type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  end
  describe "Whateve" do
    it "As an admin lists all Shelters in the system listed in reverse alphabetical order by name" do
      visit "/admin/shelters"
save_and_open_page
      expect(@shelter2.name).to appear_before(@shelter3.name)
      expect(@shelter3.name ).to appear_before(@shelter1.name)
      expect(@shelter2.name).to appear_before(@shelter1.name)
    end
  end
end