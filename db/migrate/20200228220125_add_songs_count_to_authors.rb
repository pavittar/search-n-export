class AddSongsCountToAuthors < ActiveRecord::Migration
  def self.up
    add_column :authors, :songs_count, :integer, default: 0
  end

  def self.down
    remove_column :authors, :songs_count
  end
end
