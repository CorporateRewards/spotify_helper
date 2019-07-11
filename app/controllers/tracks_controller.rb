class TracksController < ApplicationController
  before_action :refresh_access

  def create
    @track = Track.create(track_params)
  end

  def new
    @track = Track.new
  end

  def spotify_track
    RSpotify::Track.find([params[:uid]])
  end

  def add_a_track
    # Find the track on spotify
    spotify_track

    # See if track is in database
    track = Track.find_or_initialize_by(track_id: spotify_track[0].id)
    add_to_playlist(spotify_track)
    track.update!(
      name: spotify_track[0].name,
      artist: spotify_track[0].artists[0].name,
      track_id: spotify_track[0].id,
      uri: spotify_track[0].uri,
      metadata: spotify_track
    )
    add_vote(track)
  end

  def add_vote(track)
    vote = track.votes.find_or_create_by(user: user)
    if vote.update(vote: params[:vote])
      respond_to :js
    else
      flash.notice = 'Sorry, something went wrong, try again please'
      redirect_to :back
    end
  end

  def add_to_playlist(track)
    playlist.add_tracks!(track)
  end

  def index
    @sorted_playlist = Track.sorted_by_most_votes
    @votes = user.votes.where.not(track_id: nil)
  end

  def show
    @playlist = Track.sorted_by_most_votes
  end

  def track_details
    @track = RSpotify::Track.find([params[:track]])
    respond_to do |format|
      format.html
      format.js
    end
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
      headers: { 'Authorization' => "Authorization: Bearer #{spotify_access_token}" }
    )
  end

  def play_tracks
    Player.new(spotify_user).play_tracks
  end

  def pause_tracks
    Player.new(spotify_user).pause_tracks
  end

  def play_individual_track
    Player.new(spotify_user).play_track(params[:track])
  end

  def navigate_track
    Player.new(spotify_user, params).navigate
    currently_playing
    @votes = user.votes.where.not(track_id: nil)
    assign_recommended_tracks
  end

  def assign_recommended_tracks
    @recommended = RSpotify::Recommendations.generate(
      limit: 8,
      seed_tracks: tracks_liked_by_user(user).map(&:track_id)
    )
  end

  def tracks_liked_by_user(user)
    user_votes = Vote.where(user_id: user).pluck(:track_id)
    Track.find(user_votes).sample(5)
  end

  def volume_control
    Player.new(spotify_user, params).change_volume
  end
end
