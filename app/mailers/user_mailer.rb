class UserMailer < ApplicationMailer
  def welcome_email(user)
    mail(to: user.email, subject: "[Bem-vindo(a) ao PetGatô]")
  end
end