require 'rails_helper'

RSpec.describe "Health check", type: :request do
  describe "GET /health" do
    it "does return 200 status" do
      get '/health'
      expect(response).to have_http_status(200)
    end
  end
end
