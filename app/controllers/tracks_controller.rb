class TracksController < ApplicationController

  def create
    track = RSpotify::Track.find([params[:uid]])
    if !Track.exists?(track_id: track[0].id)
      playlist.add_tracks!(track)
      add_track = Track.create(:name => track[0].name, :artist => track[0].artists[0].name, :track_id => track[0].id)
      track_id = Track.where(track_id: track[0].id).first
      track_id.votes.create(vote: params[:vote])
    else
      track_id = Track.where(track_id: track[0].id).first
      track_id.votes.create(vote: params[:vote])
    end
    redirect_to root_url
  end

  def show
    @playlist = Track.all.sort_by {|track| track.sum_total_votes }.reverse
    @currently_playing = spotify_user.currently_playing
    date = DateTime.parse(spotify_user.currently_playing.album.release_date)
    @released_date = date.strftime('%b %d %Y')      
  end

  def destroy
    track = RSpotify::Track.find([params[:uid]])
    playlist.remove_tracks!(track)
    redirect_to root_url
  end

  def play
    spotify_user.play_track("spotify:track:0bAM9qivrntXnHyklRRx39")
    redirect_to root_url
  end

end