class User < ApplicationRecord
  has_secure_password
  has_one_attached :photo

  #Confere se o usuário cadastrou um nome e um email único e válido
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  #Confere se a senha do usuário tem pelo menos 8 caracteres
  validates :password, length: {minimum: 8}

end