require 'rails_helper'
# require 'spec_helper'


RSpec.describe "Weathers", type: :request do

  describe "GET /max", :caching => true do  
    it 'should returns 200, when max present' do
      allow(Rails.cache).to receive(:read).with('api_error').and_return(nil)
      allow(Rails.cache).to receive(:read).with('max').and_return(17)
      get "/weather/historical/max"
      json = JSON.parse(response.body)  
      expect(response.status).to eq(200)
    end

    it 'should returns 200, when max is nil, historical cache present' do
      allow(Rails.cache).to receive(:read).with('api_error').and_return(nil)
      allow(Rails.cache).to receive(:read).with('max').and_return(nil)
      allow(Rails.cache).to receive(:read).with('historical').and_return(HISTORICALAPI)
      get "/weather/historical/max"
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
    end

    it 'should returns 404 when api error' do
      allow(Rails.cache).to receive(:read).with('api_error').and_return(JSONUNAVAILABLE)
      get "/weather/historical/max"
      json = JSON.parse(response.body)
      expect(response.status).to eq(404)
    end
  end

  # describe "GET /max", :caching => true do  
  #   it "returns valid json" do
  #     VCR.use_cassette('ddd') do
  #       uri = URI.parse(URLH)
  #       responseHTTP = Net::HTTP.get(uri) 
  #       # expect(response).to eq(404)
  #       get "/weather/historical/max"
  #       expect(response.status).to eq(404)
  #     end
  #   end
  # end

  # describe "GET /min" do
  #   it "returns http success" do
  #     get "/weather/historical/min"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /current" do
  #   it "returns http success" do
  #     get "/weather/current"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /by_time" do
  #   it "returns http success" do
  #     get "/weather/historical/by_time"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /avg" do
  #   it "returns http success" do
  #     get "/weather/historical/avg"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /historical" do
  #   let(:historical) do
  #     { 
  #       :ObserveTime => Time.now.to_i, 
  #       :Temperature => 17,
  #       ObserveDataTime: Time.now
  #     }
  #   end
  #   it "returns http success" do
  #     get "/weather/historical"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
