class CreateDirectors < ActiveRecord::Migration[5.0]

  def change
    create_table :directors do |t|
      t.integer :user_id
    end
  end

end
