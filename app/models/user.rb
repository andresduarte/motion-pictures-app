class User < ActiveRecord::Base

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_secure_password

  has_one :writer
  has_one :director

end
