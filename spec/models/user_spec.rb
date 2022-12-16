require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do 
    user = User.create username: "Pekka", password: "Abc", password_confirmation: "Abc"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with all lowercase password" do
    user = User.create username: "Pekka", password: "abcdef", password_confirmation: "abcdef"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }
  
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end
  
    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do 
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating({user: user}, 20)

      expect(user.favorite_style).to eq(beer.style.name)
    end

    it "is the style with highest average rating if several rated" do
      create_beers_with_many_ratings({user: user, style: FactoryBot.create(:style, name: 'Lager')}, 10, 20, 30)
      beer = create_beer_with_rating({user: user, style: FactoryBot.create(:style, name: 'Pale Ale')}, 25)

      expect(beer.style.name).to eq('Pale Ale')
      expect(user.favorite_style).to eq(beer.style.name)
    end
  end


  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have one" do 
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating({user: user}, 20)

      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end

    it "is the brewery with highest average rating if several rated" do
      brewery1 = FactoryBot.create(:brewery, name: 'LessSuperBrew', year: 2001)
      create_beers_with_many_ratings({user: user, brewery: brewery1}, 10, 20, 30)
      brewery2 = FactoryBot.create(:brewery, name: 'SuperBrew', year: 2000)
      beer = create_beer_with_rating({user: user, brewery: brewery2}, 25)

      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end
  end
end
