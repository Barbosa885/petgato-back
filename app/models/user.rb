class User < ApplicationRecord
  has_secure_password
  has_one_attached :photo

  #Confere se o usuário cadastrou nome e email único
  #Usa a gem email-validator para conferir se o email possui o @ com caracters antes e depois dele
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true

  #Confere se a senha do usuário tem pelo menos 8 caracteres
  validates :password, length: {minimum: 8}

end