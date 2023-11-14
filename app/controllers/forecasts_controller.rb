class ForecastsController < ApplicationController
  OPEN_WEATHER_MAP_API_KEY = '0ed0824664ccf6fbd36d76c88b1262a1'
  MAX_CACHE_TIME = 30.minutes

  def new
    # This action will render a view with a form to input the address or zip code
  end

  def show
    # Extract the address or zip code from params
    address = params[:search_term]

    # Fetch or retrieve cached weather data
    weather = fetch_weather_data(address)
    @weather_data = weather[:data]
    @weather_cached_at = weather[:cached_at]

    # Fetch or retrieve cached extended forecast data
    forecast = fetch_extended_forecast(address)
    @extended_forecast = forecast[:data]
    @extended_forecast_cached_at = forecast[:cached_at]
  end

  private

  def fetch_weather_data(address)
    postal_code = get_postal_code(address)

    # Check cache for this postal code within the last 30 mins
    Rails.cache.fetch("current_weather_#{postal_code}", expires_in: MAX_CACHE_TIME) do
      # Fetch from API if not cached, then cache the result
      response = HTTParty.get("#{owm_url}weather?zip=#{postal_code}&appid=#{OPEN_WEATHER_MAP_API_KEY}")
      { data: JSON.parse(response.body), cached_at: Time.current }
    end
  end

  def fetch_extended_forecast(address)
    postal_code = get_postal_code(address)

    # Check cache for extended forecast
    Rails.cache.fetch("extended_forecast_#{postal_code}", expires_in: MAX_CACHE_TIME) do
      response = HTTParty.get("#{owm_url}forecast?zip=#{postal_code}&appid=#{OPEN_WEATHER_MAP_API_KEY}")
      { data: JSON.parse(response.body), cached_at: Time.current }
    end
  end

  def owm_url
    "http://api.openweathermap.org/data/2.5/"
  end

  def get_postal_code(address)
    safe_address = address.parameterize.underscore
    Rails.cache.fetch("postal_code_for_address_#{safe_address}", expires_in: 30.minutes) do
      # Use the geocoder gem to clean the string input and figure out the postal code
      Geocoder.search(address).first.postal_code
    end
  end
end
