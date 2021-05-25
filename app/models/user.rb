class User < ApplicationRecord
  has_secure_password
  has_one_attached :photo

  #Confere se o usuário cadastrou o nome e email
  validates :name, presence: true
  validates :email, presence: true

  #Confere se a senha do usuário tem pelo menos 8 caracteres
  validates :password, length: {minimum: 8}
  
  #Confere se o email do usuário já está cadastrado
  validates :email, uniqueness: true
  #Usa a gem email-validator para conferir se o email possui o @ com caracters antes e depois dele
  validates :email, email: true

end