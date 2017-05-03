class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :artist
      t.string :track_id

      t.timestamps
    end
  end
end
