require 'net/http'

class CnbApi::Fetcher
  BASE_URL = 'https://api.cnb.cz'

  def initialize(path = '/cnbapi/exrates/daily', parameters={})
    @path = path
    @parameters = parameters
  end

  def fetch_data
    file_name_date = @parameters[:date] || Time.current.to_date
    file_name = file_name_date.strftime('%Y-%m-%d-daily_data.dump')
    daily_dump = DailyDump.find_by(file_name: file_name);
    return daily_dump.id if daily_dump.present?
  
    res = make_api_request
    raise StandardError.new(res) unless res.is_a?(Net::HTTPSuccess)
  
    daily_dump_id = create_daily_dump(file_name, res.body)
    CnbApi::ProcessorWorker.perform_async(daily_dump_id)
    return daily_dump_id
  rescue => e
    # Handle the exception
    # TODO: deal with this by alerting and decide how(timing) to retry
    nil
  end

  private

  def make_api_request
    uri = URI(BASE_URL + @path)
    uri.query = URI.encode_www_form(@parameters)
    Net::HTTP.get_response(uri)
  end

  def create_daily_dump(file_name, payload)
    DailyDump.create!(file_name: file_name, payload: JSON.parse(payload)).id
  end
end
