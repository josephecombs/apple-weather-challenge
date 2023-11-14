# spec/controllers/forecasts_controller_spec.rb

require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  describe 'GET #show' do
    before do
      # Stub the external API and Geocoder calls
      allow(HTTParty).to receive(:get).and_return(double(body: { data: {}, cached_at: Time.current }.to_json))
      allow(Geocoder).to receive(:search).and_return([double(postal_code: '12345')])

      # probably a better way of achieving this but works for time being
      Rails.cache.clear
      # You might need additional setup here, depending on your application's configuration
    end

    it 'assigns @weather_data' do
      get :show, params: { search_term: 'Test Address' }
      expect(assigns(:weather_data)).to_not be_nil
    end

    it 'assigns @weather_cached_at' do
      get :show, params: { search_term: 'Test Address' }
      expect(assigns(:weather_cached_at)).to_not be_nil
    end

    it 'assigns @extended_forecast' do
      get :show, params: { search_term: 'Test Address' }
      expect(assigns(:extended_forecast)).to_not be_nil
    end

    it 'assigns @extended_forecast_cached_at' do
      get :show, params: { search_term: 'Test Address' }
      expect(assigns(:extended_forecast_cached_at)).to_not be_nil
    end

    it 'caches the weather data for 30 minutes and cache prevents extra network requests' do
      Timecop.freeze(Time.current) do
        # Expect HTTParty.get to be called once for weather and extended forecast
        expect(HTTParty).to receive(:get).twice.and_return(double(body: { data: {}, cached_at: Time.current }.to_json))

        # First request - this should hit the API
        get :show, params: { search_term: 'Test Address' }

        # Advance time by 29 minutes - data should still be in cache
        Timecop.travel((ForecastsController::MAX_CACHE_TIME - 1.minute).from_now)

        # Second request - this should NOT hit the API again
        expect(HTTParty).not_to receive(:get)
        get :show, params: { search_term: 'Test Address' }
      end
    end

    it 'caches the weather data for 30 minutes and cache allows extra network requests' do
      Timecop.freeze(Time.current) do
        # Expect HTTParty.get to be called once for weather and extended forecast
        expect(HTTParty).to receive(:get).twice.and_return(double(body: { data: {}, cached_at: Time.current }.to_json))

        # First request - this should hit the API
        get :show, params: { search_term: 'Test Address' }

        # Advance time by 31 minutes from the original time - cache should expire
        Timecop.travel((ForecastsController::MAX_CACHE_TIME + 1.minute).from_now)

        # Third request - this should hit the API again as the cache has expired
        expect(HTTParty).to receive(:get).twice.and_return(double(body: { data: {}, cached_at: Time.current }.to_json))
        get :show, params: { search_term: 'Test Address' }
      end
    end
  end
end
