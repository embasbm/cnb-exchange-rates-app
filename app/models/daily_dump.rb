class DailyDump < ApplicationRecord
  validates :file_name, uniqueness: { case_sensitive: false }
end
