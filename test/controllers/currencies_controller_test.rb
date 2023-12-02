require 'test_helper'

class CurrenciesControllerTest < ActionController::TestCase
  def setup
    request_date_day = (Date.current.saturday? || Date.current.sunday?) ? Date.current.prev_occurring(:friday) : Date.current
    @currency_today = currencies(:today)
    @currency_today.update(valid_for: request_date_day)
    @currency_prev_day = currencies(:yesterday)
    @currency_prev_day.update(valid_for: request_date_day-1.day)
  end

  test "should get home with currencies for today" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currencies)

    today_currencies = assigns(:currencies)

    assert_includes today_currencies, @currency_today
    refute_includes today_currencies, @currency_prev_day
  end
end
