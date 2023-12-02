require 'sidekiq'
require 'sidekiq-cron'

Sidekiq::Cron::Job.create(
  name: 'Daily CNB API exchange rates fetcher worker',
  cron: '0 6 * * 1-5', # The cron job is scheduled to run every day (Monday to Friday) at 6 AM.
  class: 'CnbApi::FetcherWorker',
  args: {path: '/cnbapi/exrates/daily', parameters: {lang: 'EN'}}
)
