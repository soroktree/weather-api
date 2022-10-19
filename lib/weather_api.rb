module WeatherApi
    class GetWeatherApi
        def self.get_weather_current(urlc)
            get_weather_from_api(urlc)
        end

        def self.get_weather_historical(urlh)
            get_weather_from_api(urlh)
        end

        private 

        def self.get_weather_from_api(url)
            @uri = URI.parse(url)
            @response = Net::HTTP.get(@uri) 
            weatherson = JSON.parse(@response)
        end    
    end
end