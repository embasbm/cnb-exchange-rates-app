require 'sidekiq'
require 'sidekiq-cron'

Sidekiq::Cron::Job.create(
  name: 'CnbApi::FetcherWorker',
  cron: '0 6 * * *', # Run daily at 6 AM, TODO: discuss this
  class: 'CnbApi::FetcherWorker'
)
