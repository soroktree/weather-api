require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_client do |config|
  Rails.application.config.after_initialize do
      GetWeatherJob.perform_now()
  end
end