class Currency < ApplicationRecord
  validates :currency_code, uniqueness: { case_sensitive: false }

  scope :valid_for, -> (day) { Currency.where(valid_for: day.beginning_of_day..day.end_of_day) }

  broadcasts_to ->(currency) { "currencies" }, inserts_by: :prepend
end
