class TracksController < ApplicationController

  before_action :refresh_access, only: [:next_track, :previous_track]
  def user
    user ||= RSpotify::User.find('crtechteam')

  end

  def player
    player ||= user.player
  end


  def user_auth
      @user = SpotifyAuth.last
      @user_auth = @user.sp_user_hash["credentials"].token
  end

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
    redirect_to root_url
  end


  def show
    @playlist = Track.sorted_by_most_votes
    @volume = player.instance_variable_get(:@device).instance_variable_get(:@volume_percent)
    @user_auth
  end

  def track_details
    @track = RSpotify::Track.find([params[:track]])
  end

  def update_playlist
    @alltracks = Track.made_the_playlist

    if !@alltracks.empty?
      @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
      @playlist.replace_tracks!(@alltracks.flatten)
    end
    redirect_to root_url
  end

  def destroy
    track = RSpotify::Track.find([params[:uid]])
    playlist.remove_tracks!(track)
    redirect_to root_url
  end

  def play_tracks
    player.play()
    redirect_to root_url
  end


  def pause_tracks
    player.pause()
    redirect_to root_url
  end

  def play_individual_track
    player.play_track(nil, params[:track])
    redirect_to root_url
  end

  def next_track
    @urlstring_to_post = "https://api.spotify.com/v1/me/player/next"
    @result = HTTParty.post(@urlstring_to_post.to_str, 
      :body => { 
      },
      :headers => { "Authorization" => "Authorization: Bearer #{user_auth}" })

    redirect_to root_url
  end

  def previous_track
    @urlstring_to_post = "https://api.spotify.com/v1/me/player/previous"
    @result = HTTParty.post(@urlstring_to_post.to_str, 
      :body => { 
      },
      :headers => { "Authorization" => "Authorization: Bearer #{user_auth}" })
    redirect_to root_url
  end

  def volume_control
    volume = player.instance_variable_get(:@device).instance_variable_get(:@volume_percent).to_i
    if params[:change] == "1"
      volume += 10
      player.volume(volume)
    else
      volume -= 10
      player.volume(volume)
    end
  end 

end
