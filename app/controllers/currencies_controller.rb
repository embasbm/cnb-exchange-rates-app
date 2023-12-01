class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.valid_for_today
  end
end
