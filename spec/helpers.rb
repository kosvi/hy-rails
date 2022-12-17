module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_beer_with_brewery(object)
    beer = FactoryBot.create(:beer, brewery: object[:brewery])
  end
  
  def create_beer_with_style(object)
    beer = FactoryBot.create(:beer, style: object[:style])
  end
  
  def create_beer_with_rating(object, score)
    if object[:style]
      beer = create_beer_with_style(object)
    elsif object[:brewery]
      beer = create_beer_with_brewery(object)
    else
      beer = FactoryBot.create(:beer)
    end
  
    FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
    beer
  end
  
  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
    end
  end

  def create_weather_for_place(city)
    allow(WeathermappingApi).to receive(:weather_in).with(city).and_return(
      Weather.new(temperature: 5, weather_icons: ["http://fake.image.url"], wind_speed: 5.5, wind_dir: "S")
    )
  end
end
