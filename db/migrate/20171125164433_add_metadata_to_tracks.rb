class AddMetadataToTracks < ActiveRecord::Migration[5.0]
  def change
    add_column :tracks, :metadata, :text
  end
end
