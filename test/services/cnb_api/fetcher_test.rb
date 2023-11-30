require 'test_helper'
require 'minitest/mock'

class CnbApi::FetcherTest < ActiveSupport::TestCase
  fixtures :daily_dumps

  test "execute returns DailyDump ID when daily dump exists" do
    daily_dump = daily_dumps(:one)
    fetcher = CnbApi::Fetcher.new('/some_path', date: daily_dump.file_name.to_date)

    assert_equal daily_dump.id, fetcher.execute
  end

  test "execute creates DailyDump and returns ID when daily dump does not exist" do
    response_body = { data: 'test' }.to_json
    mock_response = Minitest::Mock.new
    mock_response.expect(:is_a?, true, [Object])
    mock_response.expect(:body, response_body)

    Net::HTTP.stub(:get_response, mock_response) do
      fetcher = CnbApi::Fetcher.new('/some_path', date: Date.parse('2022-11-29'))

      assert_difference 'DailyDump.count', 1 do
        assert_kind_of Integer, fetcher.execute
      end
    end

    mock_response.verify
  end

  test "execute returns nil when API request fails" do
    mock_response = Minitest::Mock.new
    mock_response.expect(:is_a?, true, [Object])

    Net::HTTP.stub(:get_response, mock_response) do
      fetcher = CnbApi::Fetcher.new('/some_path', date: Date.parse('2022-11-29'))

      assert_nil fetcher.execute
    end

    mock_response.verify
  end
end