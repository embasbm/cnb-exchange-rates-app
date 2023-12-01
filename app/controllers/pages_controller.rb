class PagesController < ApplicationController
  def home
    @currencies = Currency.valid_for_today
  end
end
