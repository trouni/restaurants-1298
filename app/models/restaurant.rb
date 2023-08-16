class Restaurant < ApplicationRecord
  # associations (has_many / belongs_to)
  has_many :reviews, dependent: :destroy # restaurant.reviews
  # validates :column_name, validation
  validates :name, presence: true

  # geocoded_by <name of the column where the address is stored>
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  # after_validation(:geocode, { if: :will_save_change_to_address? })
end
