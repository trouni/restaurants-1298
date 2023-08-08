class Restaurant < ApplicationRecord
  # associations (has_many / belongs_to)
  # validates :column_name, validation
  validates :name, presence: true
end
