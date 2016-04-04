class ContactMailer < ActionMailer::Base
  default from: ENV['SENDER_EMAIL']

  def contact_message(name, email, message)
    @name = name
    @email = email
    @message = message

    mail to: 'colinhagan@gmail.com', from: @email, subject: "New message from contact form on Energy X Fitness"
  end
end
