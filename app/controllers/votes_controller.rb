class VotesController < ApplicationController

  def new
    track = Track.find_or_create_by(id: params[:dbid])
    vote = track.votes.find_or_create_by(user: current_user)
    vote.update(vote: params[:vote])
    redirect_to root_url
  end

  def destroy 
    track = Track.find(params[:dbid])
    track.destroy
    redirect_to root_url
  end

end