class CnbApi::FetcherWorker
  include Sidekiq::Worker

  def perform(args)
    return if Date.current.saturday? || Date.current.sunday?
    fetcher = CnbApi::Fetcher.new(args)
    fetcher.fetch_data
  end
end
