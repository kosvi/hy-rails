# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

b1 = Brewery.create name: "Koff", year: 1897
b2 = Brewery.create name: "Malmgard", year: 2001
b3 = Brewery.create name: "Weihenstephaner", year: 1040

be1 = b1.beers.create name: "Iso 3", style: "Lager"
be2 = b1.beers.create name: "Karhu", style: "Lager"
b1.beers.create name: "Tuplahumala", style: "Lager"
be3 = b2.beers.create name: "Huvila Pale Ale", style: "Pale Ale"
b2.beers.create name: "X Porter", style: "Porter"
b3.beers.create name: "Hefeweizen", style: "Weizen"
b3.beers.create name: "Helles", style: "Lager"

u1 = User.create username: "testuser", password: "Test", password_confirmation: "Test"
r1 = Rating.new score: 15
r1.beer = be1
r1.user = u1
r1.save
r2 = Rating.new score: 40
r2.beer = be2
r2.user = u1
r2.save
r3 = Rating.new score: 33
r3.beer = be3
r3.user = u1
r3.save

bc1 = BeerClub.create name: "BeginnersClub", founded: 1900
m1 = Membership.new
m1.user = u1
m1.beer_club = bc1
m1.save