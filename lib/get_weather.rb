
module GetWeather 
        require 'net/http'
        require 'json'

        def load_weather(weatherson, weather_type)
            return false unless ['historical','current_job','current'].include? weather_type
            if weatherson.member?("Code") 
                Rails.cache.write('api_error', weatherson)
                return false #в случае api error фиксируем ошибку и выходим
            end
            Rails.cache.delete('api_error') #очищаем кэш от ошибок
            
            set_table_weatherhour_from_hash(weatherson, weather_type) #сохраняем в бд
            @weathercast = get_historical_from_hash(weatherson) #убираем лишние значения из json/api

            if weather_type == 'current_job'
                @weathercast = Rails.cache.read('historical')
                @weathercast[0] = @current_weather
            end

            Rails.cache.write('current', @weathercast.first)
            Rails.cache.write('historical', @weathercast) unless weather_type == 'current'
            return true
        end

        def publicize_methods
            saved_private_instance_methods = self.private_methods
            self.class_eval { public *saved_private_instance_methods }
            yield
            self.class_eval { private *saved_private_instance_methods }
        end

        private

        def get_historical_from_hash(weatherson)
            weatherson.map { |w| {ObserveTime: w['EpochTime'],
                Temperature: w['Temperature']['Metric']['Value'],
                ObserveDataTime: w['LocalObservationDateTime']}}
        end

        def set_table_weatherhour_from_hash(hash,weather_type)
            maxtime = Weather.where(weather_type:['historical','current_job']).maximum(:epoch_time) || 0
            hash.each do |weather|
                if weather['EpochTime'] > maxtime
                    weatherhour = Weather.new
                    weatherhour.weather_type = weather_type
                    weatherhour.observ_date_time = weather['LocalObservationDateTime'].to_time
                    weatherhour.epoch_time = weather['EpochTime']
                    weatherhour.temperature = weather['Temperature']['Metric']['Value']
                    weatherhour.weather_text = weather['WeatherText']
                    weatherhour.save
                end
            end
        end
end