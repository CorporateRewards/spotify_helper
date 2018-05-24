class AddUserToVotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :votes, :user, foreign_key: true
  end
end
