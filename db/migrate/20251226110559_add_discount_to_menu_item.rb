class AddDiscountToMenuItem < ActiveRecord::Migration[5.0]
  def change
    add_column :menu_items, :discount, :integer
    add_column :menu_items, :valid_till, :datetime
  end
end
