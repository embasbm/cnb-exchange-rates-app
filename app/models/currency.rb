class Currency < ApplicationRecord
  validates :currency_code, uniqueness: { case_sensitive: false }
end
