require 'rails_helper'
require_relative "../../lib/weather_api"

RSpec.describe GetWeather do
    let(:get_weather_class) { Class.new { include GetWeather } }
    let(:subject) { get_weather_class.new }
    let(:weather) { Weather.new }

    describe '#load_weather' do
        example 'return false when wrong argument pass' do
            expect(subject.load_weather(HISTORICALAPI,'cur')).to eq(false)
        end

        example 'return true when argument pass' do
            expect(subject.load_weather(HISTORICALAPI,'historical')).to eq(true)
        end
    end

    describe '#set_table_weatherhour_from_hash' do 
        example 'not save to db when hash observetime less than maximum time saved to db' do
            subject.publicize_methods do
                expect{subject.set_table_weatherhour_from_hash(HISTORICALAPI, 'historical')}.
                    to_not change{Weather.count}
            end
        end

        example 'save to db when hash observetime more than maximum time saved to db' do
            subject.publicize_methods do
                expect{subject.set_table_weatherhour_from_hash(CURRENTAPI, 'current')}.
                    to change{Weather.count}
            end
        end
    end
end