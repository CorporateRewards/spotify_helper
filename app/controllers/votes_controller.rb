class VotesController < ApplicationController
  def new
    initialize_vote_track(params)
    user = current_user || User.find_by(email: current_admin.email)
    vote = track.votes.find_or_create_by(user: user)
    if vote.update(vote: params[:vote])
      flash.notice = 'Thanks for your vote!'
    else
      flash.notice = 'Sorry, something went wrong, try again please'
    end
    redirect_to :back
  end

  def create
    @sorted_playlist = Track.sorted_by_most_votes
    @votes = @user.votes.all.where.not(track_id: nil)
    @track = initialize_vote_track(params)
    vote = @track.votes.find_or_initialize_by(user: user)
    if vote.update(vote: params[:vote])
      respond_to :js
    else
      flash.notice = 'Sorry, something went wrong, try again please'
      redirect_to :back
    end
  end

  def initialize_vote_track(params)
    if params[:dbid]
      Track.find(params[:dbid])
    else
      spotify_track = RSpotify::Track.find([params[:uid]])

      # See if track is in database
      track = Track.find_or_initialize_by(track_id: spotify_track[0].id)
      playlist.add_tracks!(spotify_track)
      track.update!(
        name: spotify_track[0].name,
        artist: spotify_track[0].artists[0].name,
        track_id: spotify_track[0].id,
        uri: spotify_track[0].uri,
        metadata: spotify_track
      )
      track
    end
  end

  def destroy
    track = Track.find(params[:dbid])
    track.destroy
    redirect_to root_url
  end
end
