class TracksController < ApplicationController
  before_action :refresh_access, only: %i[next_track previous_track device_list play_individual_track]

  def spotify_user
    RSpotify::User.find('crtechteam')
  end

  def player
    spotify_user.player
  end

  def user_auth
    @user = SpotifyAuth.last
    @user_auth = @user.sp_user_hash['credentials'].token
  end

  def create
    @track = Track.create(track_params)
  end

  def new
    @track = Track.new
  end

  def add_a_track
    # Find the track on spotify
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

    vote = track.votes.find_or_create_by(user: user)
    if vote.update(vote: params[:vote])
      respond_to :js
    else
      flash.notice = 'Sorry, something went wrong, try again please'
      redirect_to :back
    end
  end

  def index
    @playlist = Track.sorted_by_most_votes
    @votes = @user.votes.all
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
    return if @alltracks.empty?

    if @alltracks.length < 100
      @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
      @playlist.replace_tracks!(@alltracks.flatten)
    else
      @first_100_tracks = @alltracks.first(100)
      @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
      @playlist.replace_tracks!(@first_100_tracks.flatten)
      length = @alltracks.length - 100
      @additional = @alltracks.last(length)

      @additional.each do |t|
        @playlist.add_tracks!(t)
      end
    end
    redirect_to root_url
  end

  def destroy
    track = RSpotify::Track.find([params[:uid]])
    playlist.remove_tracks!(track)
    redirect_to root_url
  end

  def device_list
    @urlstring_to_post = 'https://api.spotify.com/v1/me/player/devices'
    @result = HTTParty.get(
      @urlstring_to_post.to_str,
      body: {
      },
      headers: { 'Authorization' => "Authorization: Bearer #{user_auth}" }
    )
  end

  def play_tracks
    player.play
  end

  def pause_tracks
    player.pause
  end

  def play_individual_track
    player.play_track(params[:track])
  end

  def navigate_track
    @urlstring_to_post = "https://api.spotify.com/v1/me/player/#{params[:direction]}"
    @result = HTTParty.post(
      @urlstring_to_post.to_str,
      body: {},
      headers: { 'Authorization' => "Authorization: Bearer #{user_auth}" }
    )
    @currently_playing = player.currently_playing
    # @user = current_user ? current_user : User.find_by(email: current_admin.email)
    @votes = user.votes.all
    respond_to :js
  end

  def volume_control
    volume = player.instance_variable_get(:@device).instance_variable_get(:@volume_percent).to_i
    if params[:change] == '1'
      volume += 10
    else
      volume -= 10
    end
    player.volume(volume)
  end
end
