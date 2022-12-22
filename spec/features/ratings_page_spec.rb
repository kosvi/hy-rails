require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user, username: "Paavo" }

  before :each do
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

  describe "lists" do

    before :each do
      create_beers_with_many_ratings({user: user, brewery: brewery}, 5, 10, 20, 30)
    end

    it "list top 3 rated beers" do
      visit ratings_path
      # Not really pretty, could be refactored one day ... 
      expect(page.body).to include("        <tr>
          <td>anonymous</td>
          <td>30.0</td>
        </tr>
        <tr>
          <td>anonymous</td>
          <td>20.0</td>
        </tr>
        <tr>
          <td>anonymous</td>
          <td>10.0</td>
        </tr>")
    end

    it "only users own ratings on profile page" do
      create_beers_with_many_ratings({user: user2, brewery: brewery}, 15, 25, 35)
      visit user_path(user2)

      expect(page).to have_content "Has made 3 ratings, average being 25"
      expect(page).to have_content "anonymous 15"
      expect(page).to have_content "anonymous 25"
      expect(page).to have_content "anonymous 35"
    end
  end
end
