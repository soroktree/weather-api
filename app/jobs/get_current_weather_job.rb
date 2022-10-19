class GetCurrentWeatherJob < ApplicationJob
  queue_as :default
  require 'webmock/rspec'

  def perform()
    weatheresponse = WeatherApi::GetWeatherApi.get_weather_current(URLC)
    load_weather(weatheresponse, 'current_job')
  end
end
