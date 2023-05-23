# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

@shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
@shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
@pet_1 = @shelter3.pets.create(name: 'Draco', breed: 'bat dog', age: 5, adoptable: true)
@pet_2 = @shelter2.pets.create(name: 'Max', breed: 'huge weiner dog', age: 9, adoptable: true)
@pet_3 = @shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@pet_4 = @shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_5 = @shelter2.pets.create(name: 'Okie', breed: 'black lab', age: 2, adoptable: true)


@app1 = Application.create!(name: "Sarah", street_address: "1234 Dog Lane", city: "Denver", state: "CO", zipcode: 83673, description: "I love pets!", status: "In Progress")
@app2 = Application.create!(name: "Amy", street_address: '4321 Animal House St', city: 'Denver', state: 'CO', zipcode: 80238, description:"No more animals, I'm too stressed from Turing!", status: "In Progress")
@app3 = Application.create!(name: "Janet", street_address: "1111 Woofers Dr", city: "Denver", state: "CO", zipcode: 83673, description: "Okie Bokie is my favorite!", status: "In Progress")

@pet1_application = PetApplication.create!(application_id: @app1.id, pet_id: @pet_1.id)
@pet2_application = PetApplication.create!(application_id: @app1.id, pet_id: @pet_2.id)
@pet3_application = PetApplication.create!(application_id: @app1.id, pet_id: @pet_4.id)
@pet4_application = PetApplication.create!(application_id: @app2.id, pet_id: @pet_2.id)
@pet5_application = PetApplication.create!(application_id: @app2.id, pet_id: @pet_3.id)
@pet6_application = PetApplication.create!(application_id: @app3.id, pet_id: @pet_5.id)
@pet7_application = PetApplication.create!(application_id: @app3.id, pet_id: @pet_1.id)


