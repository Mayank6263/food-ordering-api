class DeviseMailer < ApplicationMailer
  def confirmation_instructions(record, token, opts={})
    opts[:subject] = "Welcome! Please confirm your account, #{record.email}" # Custom subject
    super
  end
end
