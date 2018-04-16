class CreateBannedPhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :banned_phrases do |t|
      t.string :phrase
    end
  end
end