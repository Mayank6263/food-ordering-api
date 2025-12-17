class AddLatitudeLongitudeToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :lat, :decimal
    add_column :restaurants, :long, :decimal
  end
end
