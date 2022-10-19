require 'rails_helper'

RSpec.describe Weather, type: :model do
  subject { Weather.new(temperature: 12.9,
                                weather_text: 'Cloudy',
                                observ_date_time: DateTime.now,
                                epoch_time: DateTime.now.to_i,
                                )}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a temperature" do 
    subject.temperature = nil 
    expect(subject).to_not be_valid
  end

  it "is not valid without a epoch_time" do 
    subject.epoch_time = nil 
    expect(subject).to_not be_valid
  end

  it "is not valid without a observ_date_time" do 
    subject.observ_date_time = nil 
    expect(subject).to_not be_valid
  end
  
  it "valid with correct waether type" do 
    should define_enum_for(:weather_type).with_values([:historical, :current, :current_job])
  end
end