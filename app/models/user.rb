class User < ActiveRecord::Base

  has_secure_password

  has_one :writer
  has_one :director
  has_many :user_films
  has_many :films, through: :user_films



end
