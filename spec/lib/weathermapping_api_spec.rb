require 'rails_helper'

describe "WeathermappingApi" do
 describe "in case of cache miss" do

    before :each do
      Rails.cache.clear
    end

    it "When HTTP GET returns success, it is parsed and returned" do

      canned_answer = <<-END_OF_STRING
      {"request":{"type":"City","query":"Helsinki, Finland","language":"en","unit":"m"},"location":{"name":"Helsinki","country":"Finland","region":"Southern Finland","lat":"60.176","lon":"24.934","timezone_id":"Europe\/Helsinki","localtime":"2022-12-17 21:04","localtime_epoch":1671311040,"utc_offset":"2.0"},"current":{"observation_time":"07:04 PM","temperature":-2,"weather_code":116,"weather_icons":["https:\/\/cdn.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0004_black_low_cloud.png"],"weather_descriptions":["Partly cloudy"],"wind_speed":17,"wind_degree":190,"wind_dir":"S","pressure":1023,"precip":0,"humidity":86,"cloudcover":75,"feelslike":-8,"uv_index":1,"visibility":10,"is_day":"no"}}
      END_OF_STRING

      stub_request(:get, /.*helsinki/).to_return(body: canned_answer, headers: { 'Content-Type' => "application/json; Charset=UTF-8" })

      weather = WeathermappingApi.weather_in("helsinki")

      expect(weather.temperature).to eq(-2)
      expect(weather.weather_code).to eq(116)
    end

    it "When HTTP GET returns no entry, an empty Hash is returned" do
      canned_answer = <<-END_OF_STRING
      {"success":false,"error":{"code":615,"type":"request_failed","info":"Your API request failed. Please try again or contact support."}}
      END_OF_STRING

      stub_request(:get, /.*nonexistent/).to_return(body: canned_answer, headers: { 'Content-Type' => "application/json; Charset=UTF-8" })

      weather = WeathermappingApi.weather_in("nonexistent")

      expect(weather).to eq({})
    end
  end
end
