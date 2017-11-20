class ChangeColumnType < ActiveRecord::Migration[5.0]
  def change
    change_column :spotify_auths, :sp_user_hash, :text
  end
end
