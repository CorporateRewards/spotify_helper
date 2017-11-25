class AddUriToTracks < ActiveRecord::Migration[5.0]
  def change
    add_column :tracks, :uri, :string
  end
end
