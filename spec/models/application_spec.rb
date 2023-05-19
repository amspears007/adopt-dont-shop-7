require "rails_helper"

RSpec.describe Application do
  describe "relationships" do
    it { should have_many :pet_applications }
  end
end