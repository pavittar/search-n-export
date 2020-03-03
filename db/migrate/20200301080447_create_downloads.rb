class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.integer :kind
      t.integer :status
      t.string :path
      t.string :filename

      t.timestamps null: false
    end
  end
end