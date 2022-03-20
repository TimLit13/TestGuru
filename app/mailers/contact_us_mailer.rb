class ContactUsMailer < ApplicationMailer

  default to: -> { Admin.pluck(:email) }

  def new_contact_us_message(user)
    @contact_us_question = user

    mail(subject: "New contact us question from user: #{@contact_us_question[:email]}")
  end
end
