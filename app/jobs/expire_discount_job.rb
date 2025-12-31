class ExpireDiscountJob < ApplicationJob
  queue_as :default

  def perform(menu)
    menu.update!(valid_till: nil, discount: nil)
  end
end
