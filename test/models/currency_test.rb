require "test_helper"

class CurrencyTest < ActiveSupport::TestCase
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
end