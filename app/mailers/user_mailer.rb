class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome_email.subject
  #

  default from: "notifications@example.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Welcome to My Awesome App")
  end
end
