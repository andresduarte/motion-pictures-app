class Writer < ActiveRecord::Base

  belongs_to :user
  has_many :writer_films
  has_many :films, through: :writer_films

end
