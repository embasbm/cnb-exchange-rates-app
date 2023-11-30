class CnbApi::FetcherWorker
  include Sidekiq::Worker

  def perform
    fetcher = CnbApi::Fetcher.new('/cnbapi/exrates/daily', { date: Date.current })
    fetcher.fetch_data
  end
end
