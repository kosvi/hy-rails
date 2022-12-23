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

s1 = Style.create name: "Lager"
s2 = Style.create name: "Pale Ale"
s3 = Style.create name: "Porter"

be1 = b1.beers.new name: "Iso 3"
be1.style = s1
be1.save
be2 = b1.beers.new name: "Karhu"
be2.style = s1
be2.save
be3 = b1.beers.new name: "Tuplahumala"
be3.style = s1
be3.save
be4 = b2.beers.new name: "Huvila Pale Ale"
be4.style = s2
be4.save
be5 = b2.beers.new name: "X Porter"
be5.style = s3
br5.save
be6 = b3.beers.new name: "Hefeweizen"
be6.style = s2
be6.save
be7 = b3.beers.new name: "Helles"
be7.style = s3
be7.save

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