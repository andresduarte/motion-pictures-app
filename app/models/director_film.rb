class DirectorFilm < ActiveRecord::Base

  belongs_to :director
  belongs_to :film

end
