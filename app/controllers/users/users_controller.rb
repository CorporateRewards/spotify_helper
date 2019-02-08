class Users::UsersController < ApplicationController

  def user_votes
    @user = current_user || User.find_by(email: current_admin.email)
    @votes = @user.votes.all
  end

end
