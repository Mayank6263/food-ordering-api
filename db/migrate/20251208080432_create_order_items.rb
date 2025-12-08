# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.references :order_id
      t.references :menu_item__id

      t.timestamps
    end
  end
end
