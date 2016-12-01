class CreateFilms < ActiveRecord::Migration[5.0]

  def change
    create_table :films do |t|
      t.string :title
      t.string :genre
      t.string :runtime
      t.string :writer
      t.string :director
    end  
  end

end
