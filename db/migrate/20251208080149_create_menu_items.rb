# frozen_string_literal: true

class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.references :restaurant_id

      t.timestamps
    end
  end
end
