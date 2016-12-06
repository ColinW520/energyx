class RegistrationMailer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL']

  def confirmation_message(name, email, message)
    @name = name
    @email = email
    @message = message

    mail to: @email, subject: "Registration Confirmation: EnergyX Resolve To Row 2017"
  end
end
