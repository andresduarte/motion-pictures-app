class Director < ActiveRecord::Base

  belongs_to :user
  has_many :director_films
  has_many :films, through: :director_films
  
end
