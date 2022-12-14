class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week) { get_places_in(city) }
  end

  def self.place_with_id(place_id)
    Rails.cache.fetch(place_id, expires_in: 1.week) { get_place_by_id(place_id) }
  end

  def self.get_places_in(city)
    url = "https://beermapping.com/webservice/loccity/#{key}/"
    # url = "http://beermapping.com/webservice/loccity/#{key}/" unless ENV["RAILS_ENV"] == "production"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) && places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do |place|
      Place.new(place)
    end
  end

  def self.get_place_by_id(place_id)
    url = "https://beermapping.com/webservice/locquery/#{key}/"

    response = HTTParty.get "#{url}#{place_id}"
    place = response.parsed_response["bmp_locations"]["location"]

    return {} if place.is_a?(Array)

    Place.new(place)
  end

  def self.key
    return nil if Rails.env.test?
    raise 'BEERMAPPING_APIKEY env variable not defined' if ENV['BEERMAPPING_APIKEY'].nil?

    ENV.fetch('BEERMAPPING_APIKEY')
  end
end
