# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.decimal :total_amount
      t.string :status
      t.references :user_id

      t.timestamps
    end
  end
end
