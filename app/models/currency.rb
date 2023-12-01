class Currency < ApplicationRecord
  validates :currency_code, uniqueness: { case_sensitive: false }

  scope :valid_for_today, -> { Currency.where(valid_for: Date.current.beginning_of_day..Date.current.end_of_day) }
end
