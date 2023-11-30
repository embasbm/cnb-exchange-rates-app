require 'sidekiq'
require 'sidekiq-cron'

Sidekiq::Cron::Job.create(
  name: 'CnbApi::FetcherWorker',
  cron: '0 6 * * *', # Run daily at 1 AM, adjust as needed
  class: 'CnbApi::FetcherWorker'
)
