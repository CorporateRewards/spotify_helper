class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :track, foreign_key: true
      t.boolean :vote

      t.timestamps
    end
  end
end
