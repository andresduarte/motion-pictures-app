class User < ActiveRecord::Base

  has_secure_password

  has_one :writer
  has_one :director
  
end
