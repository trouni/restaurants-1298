class Restaurant < ApplicationRecord
  # associations (has_many / belongs_to)
  has_many :reviews, dependent: :destroy # restaurant.reviews
  # validates :column_name, validation
  validates :name, presence: true
end
