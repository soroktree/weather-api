class Weather < ApplicationRecord
    validates :temperature, presence: true
    validates :observ_date_time, presence: true
    validates :epoch_time, presence: true
    enum weather_type: [:historical, :current, :current_job]
  
      def self.dedupe
          grouped = all.group_by{|model| [model.temperature, model.weather_text, model.epoch_time, model.observ_date_time] }
          grouped.values.each do |duplicates|
            first_one = duplicates.shift
            duplicates.each{|double| double.destroy}
          end
      end
  
      def formatted_time
        Time.at(epoch_time).strftime(' %H:%M %B %d, %Y')
      end
end
