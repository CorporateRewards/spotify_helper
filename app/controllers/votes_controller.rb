class VotesController < ApplicationController

  def new
    track = Track.find_or_create_by(id: params[:dbid])
    user = current_user ? current_user : User.find_by(email: current_admin.email)
    vote = track.votes.find_or_create_by(user: user)
    vote.update(vote: params[:vote])
    redirect_to root_url
  end

  def destroy 
    track = Track.find(params[:dbid])
    track.destroy
    redirect_to root_url
  end

end