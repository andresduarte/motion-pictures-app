class CreateWriterFilms < ActiveRecord::Migration[5.0]

  def change
    create_table :writer_films do |t|
      t.integer :writer_id
      t.integer :film_id
    end
  end

end
