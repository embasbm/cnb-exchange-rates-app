require 'test_helper'
require 'minitest/mock'

class CnbApi::FetcherTest < ActiveSupport::TestCase
  fixtures :daily_dumps

  test "fetch_data returns DailyDump ID when daily dump exists" do
    daily_dump = daily_dumps(:one)
    fetcher = CnbApi::Fetcher.new(
      path: '/some_path',
      parameters: { date: daily_dump.file_name.to_date, lang: 'EN' }
    )

    assert_equal daily_dump.id, fetcher.fetch_data
  end

  test "fetch_data creates DailyDump and returns ID when daily dump does not exist" do
    response_body = { data: 'test' }.to_json
    mock_response = Minitest::Mock.new
    mock_response.expect(:is_a?, true, [Object])
    mock_response.expect(:body, response_body)

    Net::HTTP.stub(:get_response, mock_response) do
      fetcher = CnbApi::Fetcher.new(
        path: '/some_path',
        parameters: { date: Date.parse('2022-11-29'), lang: 'EN' }
      )

      assert_difference 'DailyDump.count', 1 do
        assert_kind_of Integer, fetcher.fetch_data
      end
    end

    mock_response.verify
  end

  test "fetch_data returns nil when API request fails" do
    mock_response = Minitest::Mock.new
    mock_response.expect(:is_a?, true, [Object])

    Net::HTTP.stub(:get_response, mock_response) do
      fetcher = CnbApi::Fetcher.new(
        path: '/some_path',
        parameters: { date: Date.parse('2022-11-29'), lang: 'EN' }
      )

      assert_nil fetcher.fetch_data
    end

    mock_response.verify
  end
end
