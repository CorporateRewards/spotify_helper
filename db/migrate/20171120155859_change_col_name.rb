class ChangeColName < ActiveRecord::Migration[5.0]
  def change
      rename_column :spotify_auths, :hash, :sp_user_hash
  end
end
