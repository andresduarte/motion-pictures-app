class UserFilm < ActiveRecord::Base

  belongs_to :user_id
  belongs_to :film_id

end
