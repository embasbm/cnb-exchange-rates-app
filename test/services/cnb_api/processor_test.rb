require 'test_helper'

class CnbApi::ProcessorTest < ActiveSupport::TestCase
  fixtures :daily_dumps, :currencies

  test "execute updates currencies based on daily dump payload" do
    daily_dump = daily_dumps(:one)
    processor = CnbApi::Processor.new
    assert_difference 'Currency.count', daily_dump.payload['rates'].count do
      processor.execute(daily_dump.id)
    end

    daily_dump.payload['rates'].each do |entry|
      currency = Currency.find_by(currency_code: entry['currencyCode'])
      assert_not_nil currency
      assert_equal entry['rate'], currency.rate
      assert_equal entry['amount'], currency.amount
      assert_equal entry['country'], currency.country
      assert_equal entry['currency'], currency.currency_name
      assert_equal entry['validFor'].to_date, currency.valid_for
    end
  end

  test "execute handles missing daily dump gracefully" do
    processor = CnbApi::Processor.new

    assert_no_difference 'Currency.count' do
      processor.execute(2)
    end
  end
end
