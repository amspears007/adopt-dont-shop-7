class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, presence: true
  validates :street_address, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :zipcode, presence: true, numericality: true, length: { is: 5}
  validates :description, presence: true
end