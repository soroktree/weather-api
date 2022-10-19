class GetWeatherJob < ApplicationJob
  queue_as :default

  def perform()
    weatheresponse = HISTORICALAPI
    weatheresponse = WeatherApi::GetWeatherApi.get_weather_historical(URLH) unless Rails.env.test?
    load_weather(weatheresponse, 'historical')
  end
end
