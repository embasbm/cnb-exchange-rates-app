require "application_system_test_case"

class CurrenciesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_path
    assert_selector "p", text: "No Exchange rates available for"
  end
end
