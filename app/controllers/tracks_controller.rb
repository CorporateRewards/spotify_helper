class TracksController < ApplicationController
  before_action :refresh_access

  def create
    @track = Track.create(track_params)
  end

  def new
    @track = Track.new
  end

  def index
    @sorted_playlist = Track.sorted_by_most_votes
    @votes = user.votes.where.not(track_id: nil)
  end

  def show; end

  def destroy
    track = RSpotify::Track.find([params[:uid]])
    playlist.remove_tracks!(track)
    redirect_to root_url
  end

  def track_details
    @track = RSpotify::Track.find([params[:track]])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_playlist
    UpdatePlaylistWorker.perform_async
  end

  def find_track_on_spotify
    @spotify_track = RSpotify::Track.find([params[:uid]])
  end

  def add_a_track
    ActiveRecord::Base.transaction do
      find_track_on_spotify
      add_track_to_playlist(@spotify_track)
      add_track_locally
      add_vote(@track)
    end
  end

  def add_track_locally
    @track = Track.find_or_initialize_by(track_id: @spotify_track[0].id)

    @track.update!(
      name: @spotify_track[0].name,
      artist: @spotify_track[0].artists[0].name,
      track_id: @spotify_track[0].id,
      uri: @spotify_track[0].uri,
      metadata: @spotify_track
    )
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

  def add_track_to_playlist(track)
    playlist.add_tracks!(track)
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

  def volume_control
    Player.new(spotify_user, params).change_volume
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
end
