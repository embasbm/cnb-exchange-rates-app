class CurrenciesController < ApplicationController
  def index
    @day_of_week = (Date.current.saturday? || Date.current.sunday?) ? Date.current.prev_occurring(:friday) : Date.current
    @currencies = Currency.valid_for(@day_of_week)
  end
end
