class WeatherController < ApplicationController
   before_action :check_errors

  def current
    @current = Rails.cache.read('current')  
    ct = Time.at(@current[:ObserveTime]).to_datetime
    render json: @current.to_json, status: 200
  end

  def historical
    @historical = Rails.cache.read('historical')
    unless @historical.count == 24
        render json: {'Error': 'There is no data for the specified period'}, status: 404
    end
    render json: @historical.to_json, status: 200
  end

  def max
    max = Rails.cache.read('max')
    unless max.present? 
        @historical = Rails.cache.read('historical')
        max = @historical.map { |h| h[:Temperature] }.max
        Rails.cache.write('max', max)
    end
    render json: {'MaxTemperatureByDay': max }, status: 200
  end

  def min
    min = Rails.cache.read('min')
    unless min.present? 
        @historical = Rails.cache.read('historical')
        min = @historical.map { |h| h[:Temperature] }.min
        Rails.cache.write('min', min)
    end
    render json: {'MinxTemperatureByDay': min }, status: 200
  end

  def avg
    avg = Rails.cache.read('avg')
    unless avg.present?
        @historical = Rails.cache.read('historical')
        avg = @historical.map { |h| h[:Temperature] }.sum.fdiv(@historical.size)
        Rails.cache.write('avg', avg)
    end
    render json: { 'AverageTemperature': avg.round(1) }, status: 200
  end

  def by_time
    date = Time.now
    @weather = Weather.where(observ_date_time: (date - 24.hours)..date, weather_type:['historical','current_job'])
    @nearest ||= @weather.order(Arel.sql("ABS(epoch_time - #{params[:epoch_time].to_i})")).first   
    render status: 404 unless @nearest.present?
    render json: { 'NearestTemperature': @nearest.temperature }, status: 200  
   end

  private 

  def check_errors 
      @current = Rails.cache.read("api_error")
      if @current.present?
          render json: @current.to_json, status: 404
      end
  end
end
