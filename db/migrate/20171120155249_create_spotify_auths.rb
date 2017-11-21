class CreateSpotifyAuths < ActiveRecord::Migration[5.0]
  def change
    create_table :spotify_auths do |t|
      t.string :hash

      t.timestamps
    end
  end
end
