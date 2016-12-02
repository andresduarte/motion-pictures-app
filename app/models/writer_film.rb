class WriterFilm < ActiveRecord::Base

  belongs_to :writer
  belongs_to :film

end
