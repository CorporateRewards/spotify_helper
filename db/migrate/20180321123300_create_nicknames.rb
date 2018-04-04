class CreateNicknames < ActiveRecord::Migration[5.0]
  def change
    create_table :nicknames do |t|
      t.string :nickname
      t.references :user, foreign_key: true
      t.datetime :chosen_at
      t.boolean :hidden
    end
  end
end
