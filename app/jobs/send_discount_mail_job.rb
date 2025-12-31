class SendDiscountMailJob < ApplicationJob
  queue_as :default

  def perform(menu)

    # user_ids, @menu, users, emails = [], menu, [], []

    # @menu.orders.map do |order|
    #   user_ids << order.user_id
    #   user_ids.uniq!
    #   user_ids.each { |id| users << User.find(id) }
    #   users.uniq!
    #   users.each { |user| emails << user.email }
    #   emails.uniq!
    # end

    @menu = menu
    user_ids = menu.orders.select(:user_id).distinct
    users = user_ids.map {|user| User.find(user.user_id)}
    emails = users.map {|user| user.email }

    # For Sending Mails to users, who have ordered this dish once.
    emails.each do |email|
      DiscountNotificationMailer.discount_mail(email, @menu).deliver_now
    end

    # For Expiring a Job
    # time = menu.valid_till.strftime("%M")

    time = @menu.valid_till - Time.current
    ExpireDiscountJob.set(wait: (time/3600).hours).perform_later(@menu)
  end
end

