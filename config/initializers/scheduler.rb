require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.every '1h' do |job|
    begin 
        GetCurrentWeatherJob.perform_now()
    rescue Exception => e 
        puts "Request failed - recheduling: #{e}"
        s.in( '30s', job)
    end
end