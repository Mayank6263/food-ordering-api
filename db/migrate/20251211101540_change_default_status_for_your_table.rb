class ChangeDefaultStatusForYourTable < ActiveRecord::Migration[5.0]
  def change
    change_column_default :orders, :total_amount, from: nil, to: 0
  end
end
