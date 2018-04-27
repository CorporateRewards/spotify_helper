class TracksController < ApplicationController

  def create
    # Find the track on spotify
    spotify_track = RSpotify::Track.find([params[:uid]])

    # See if track is in database
    track = Track.find_or_initialize_by(track_id: spotify_track[0].id)
    playlist.add_tracks!(spotify_track)
    track.update!(name: spotify_track[0].name, 
      artist: spotify_track[0].artists[0].name, 
      track_id: spotify_track[0].id, 
      uri: spotify_track[0].uri, 
      metadata: spotify_track
    )
    track.votes.create(vote: params[:vote], user: current_user)

    # if !Track.exists?(track_id: track[0].id)
    #   playlist.add_tracks!(track)
    #   add_track = Track.create(:name => track[0].name, :artist => track[0].artists[0].name, :track_id => track[0].id, :uri =>track[0].uri, :metadata => track)
    #   track_id = Track.where(track_id: track[0].id).first
    #   track_id.votes.create(vote: params[:vote], user: current_user)
    # else
    #   track_id = Track.where(track_id: track[0].id).first
    #   track_id.votes.create(vote: params[:vote], user: current_user)
    # end

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
      @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
      @playlist.replace_tracks!(@tracks.flatten)
    end
    redirect_to root_url
  end

  def destroy
    track = RSpotify::Track.find([params[:uid]])
    playlist.remove_tracks!(track)
    redirect_to root_url
  end

  def play_tracks
    user = RSpotify::User.find('crtechteam')
    player = user.player
    player.play()
    redirect_to root_url
  end


  def pause_tracks
    user = RSpotify::User.find('crtechteam')
    player = user.player
    player.pause()
    redirect_to root_url
  end

end