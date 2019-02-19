class Users::UsersController < ApplicationController

  def user_votes
    @user = current_user || User.find_by(email: current_admin.email)
    @votes = @user.votes.where.not(track_id: nil)
  end

end
