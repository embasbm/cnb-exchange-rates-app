require "test_helper"

class CurrencyTest < ActiveSupport::TestCase
  def setup
    @currency_today = currencies(:today)
    @currency_today.update(valid_for: Date.current)
    @currency_prev_day = currencies(:yesterday)
    @currency_prev_day.update(valid_for: Date.current - 1)
  end

  test "should not save duplicate currency codes of AUD code" do
    existing_currency = currencies(:aud)

    duplicate_currency = Currency.new(currency_code: existing_currency.currency_code)
    assert_not duplicate_currency.save, "Saved a currency with a duplicate code"
  end

  test "should not save duplicate currency codes of aud code" do
    existing_currency = currencies(:aud)

    duplicate_currency = Currency.new(currency_code: existing_currency.currency_code.downcase)
    assert_not duplicate_currency.save, "Saved a currency with a duplicate code"
  end

  test "should save currency with unique code" do
    unique_currency = Currency.new(currency_code: 'FOO')
    assert unique_currency.save, "Failed to save a currency with a unique code"
  end

  test "valid_for_today scope should include currencies created today" do
    today_currencies = Currency.valid_for(Date.current)
    
    assert_includes today_currencies, @currency_today
    refute_includes today_currencies, @currency_prev_day
  end

  test "valid_for_today scope should not include currencies created yesterday" do
    today_currencies = Currency.valid_for(Date.current)

    refute_includes today_currencies, @currency_prev_day
  end
end
