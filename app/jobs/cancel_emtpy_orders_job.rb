class CancelEmtpyOrdersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    arr = Order.where(status: "pending")
    arr.each do |order|
     order.destroy if order.menu_items.empty?
    end
  end
end
