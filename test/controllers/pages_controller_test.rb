require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
    @currency_today = currencies(:today)
    @currency_today.update(valid_for: Date.current)
    @currency_yesterday = currencies(:yesterday)
    @currency_yesterday.update(valid_for: Date.current-1.day)
  end

  test "should get home with currencies for today" do
    get :home
    assert_response :success
    assert_not_nil assigns(:currencies)

    today_currencies = assigns(:currencies)
    assert_includes today_currencies, @currency_today
    refute_includes today_currencies, @currency_yesterday
  end
end
