require 'rails_helper'
require_relative "../../lib/weather_api"

RSpec.describe GetWeatherJob, type: :job do
    it { should respond_to(:load_weather)}
    it { should be_a(GetWeather) }

    it 'should call load_weather' do 
        expect(subject).to receive(:load_weather).with(HISTORICALAPI,'historical')
        subject.perform() 
    end
end
