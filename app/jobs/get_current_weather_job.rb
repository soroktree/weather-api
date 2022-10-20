class GetCurrentWeatherJob < ApplicationJob
  queue_as :default

  def perform()
    weatheresponse = WeatherApi::GetWeatherApi.get_weather_current(URLC)
    load_weather(weatheresponse, 'current_job')
  end
end
