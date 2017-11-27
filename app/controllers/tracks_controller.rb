class TracksController < ApplicationController

  def create
    track = RSpotify::Track.find([params[:uid]])
    if !Track.exists?(track_id: track[0].id)
      playlist.add_tracks!(track)
      add_track = Track.create(:name => track[0].name, :artist => track[0].artists[0].name, :track_id => track[0].id, :uri =>track[0].uri, :metadata => track)
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
  end

  def update_playlist
    @alltracks = Track.all.sort_by {|track| track.sum_total_votes}.pluck(:metadata).reverse
    @alltracks.delete_if {|x| x == nil }
    @tracks = @alltracks.first(100)
    if !@tracks.empty?
      @playlist_to_update = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
      @playlist_to_update.replace_tracks!(@tracks.flatten)
    end
    redirect_to root_url
  end

  def destroy
    track = RSpotify::Track.find([params[:uid]])
    playlist.remove_tracks!(track)
    redirect_to root_url
  end


end