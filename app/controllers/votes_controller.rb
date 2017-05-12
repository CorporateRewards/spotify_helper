class VotesController < ApplicationController

  def new  
    track_id = Track.where(track_id: params[:uid]).first
    if params[:dbid]
    db_track = Track.find(params[:dbid])
    end
    if track_id
      track_id.votes.create(vote: params[:vote])
    elsif db_track
      db_track.votes.create(vote: params[:vote])
    else      
      track = RSpotify::Track.find([params[:uid]])
      add_track = Track.create(:name => track[0].name, :artist => track[0].artists[0].name, :track_id => track[0].id)
      track_id = Track.where(track_id: params[:uid]).first
      track_id.votes.create(vote: params[:vote])
    end
    redirect_to root_url
  end


  def destroy 
    track = Track.find(params[:dbid])
    track.destroy
    redirect_to root_url
  end

end