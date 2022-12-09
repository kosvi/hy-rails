require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    # visit signin_path
    # fill_in('username', with: 'Pekka')
    # fill_in('password', with: 'Foobar1')
    # click_button('Log in')
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "list page lists all ratings from db and displays total count" do
    create_beers_with_many_ratings({user: user, brewery: brewery}, 10, 20, 30)
    visit ratings_path

    expect(page).to have_content "anonymous 10 Pekka"
    expect(page).to have_content "anonymous 20 Pekka"
    expect(page).to have_content "anonymous 30 Pekka"
    expect(page).to have_content "a total of 3 ratings"
  end
end
