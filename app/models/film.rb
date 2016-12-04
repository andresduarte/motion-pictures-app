class Film < ActiveRecord::Base

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_many :writer_films
  has_many :writers, through: :writer_films
  has_many :director_films
  has_many :directors, through: :director_films

end
