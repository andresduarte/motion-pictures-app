class User < ActiveRecord::Base

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_secure_password

  has_one :writer
  has_one :director

  def slug
    self.username.gsub(" ", "-").downcase
  end

end
