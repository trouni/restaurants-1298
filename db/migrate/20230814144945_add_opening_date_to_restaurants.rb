class AddOpeningDateToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :opening_date, :date
  end
end
