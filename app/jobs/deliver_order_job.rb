class DeliverOrderJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 2

  def perform(order)
    order.status = "deliver"
    order.save!
  end

end
