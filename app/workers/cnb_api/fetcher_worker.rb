class CnbApi::FetcherWorker
  include Sidekiq::Worker

  def perform(path = '/cnbapi/exrates/daily', date = Date.current, lang = 'EN')
    fetcher = CnbApi::Fetcher.new(path, { date: date, lang: lang })
    fetcher.fetch_data
  end
end
