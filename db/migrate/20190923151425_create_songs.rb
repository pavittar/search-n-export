class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.integer :author_id
      t.string :title
      t.integer :year

      t.timestamps null: false
    end
  end
end
