class CreateFilms < ActiveRecord::Migration[5.0]

  def change
    create_table :films do |t|
      t.string :title
      t.string :genre
      t.string :runtime
      t.boolean :writer
      t.boolean :director
    end
  end

end
