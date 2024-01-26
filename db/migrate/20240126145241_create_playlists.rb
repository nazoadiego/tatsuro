class CreatePlaylists < ActiveRecord::Migration[7.1]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :urlt

      t.timestamps
    end
  end
end
