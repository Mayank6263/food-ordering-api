class DiscountNotificationMailer < ApplicationMailer
  default from: "75mayanksolanki@gmail.com"
  layout "mailer"

  def discount_mail(email, menu)
    @email, @menu = email, menu
    mail(to: @email, subject:"You Got Discount On MenuItem #{ @menu.name }.")
  end
end
