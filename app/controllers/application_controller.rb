class ApplicationController < ActionController::Base
  require 'httparty'
  require 'base64'
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :currently_playing

  def playlist
    @playlist ||= RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
  end

  def authenticate_user!(*args)
    return super unless admin_signed_in?
  end

  def spotify_authorized_user
    SpotifyAuth.last
  end

  def spotify_access_token
    spotify_authorized_user.sp_user_hash['credentials'].token
  end

  def spotify_user
    return unless spotify_authorized_user

    RSpotify::User.new(spotify_authorized_user.sp_user_hash)
  end

  def user
    return unless current_user || current_admin

    @user = current_user || User.find_by(email: current_admin.email)
  end

  def refresh_access
    return unless spotify_authorized_user

    puts 'Refreshing spotify access'
    authorization_token = Base64.strict_encode64("#{ENV['spotify_id']}:#{ENV['spotify_secret']}")
    ref_token = spotify_authorized_user.sp_user_hash['credentials'].refresh_token

    spotify_token_url = 'https://accounts.spotify.com/api/token'
    @result = HTTParty.post(
      spotify_token_url,
      body: {
        grant_type: 'refresh_token',
        refresh_token: ref_token
      },
      headers: {
        'Authorization' =>
          "Basic '#{authorization_token}'"
      }
    )
    spotify_authorized_user.sp_user_hash['credentials'].token = @result['access_token']
    puts 'Spotify access refreshed' if spotify_authorized_user.save
  end

  def player
    @player = spotify_user.player
  end

  def track_progress
    @progress = spotify_user.player.progress
    respond_to do |format|
      format.json { render json: @progress }
    end
  end

  def update_active_track
    currently_playing

    respond_to do |format|
      format.js
    end
  end

  def currently_playing
    assign_track_variables
    assign_user_votes

    respond_to do |format|
      format.html
      format.json { render json: @currently_playing }
      format.js
    end
  end

  private

  def assign_track_variables
    return @currently_playing = nil if spotify_user.nil?

    assign_current_track
    assign_previous_track
    assign_next_track
    current_track_progress
  end

  def assign_user_votes
    return unless user.present?

    @votes = user.votes.where.not(track_id: nil) || nil
  end

  def assign_current_track
    @currently_playing = player.currently_playing
    @track = Track.where(track_id: @currently_playing.id).pluck(:id)
  end

  def assign_previous_track
    location = 0
    playlist.tracks.each.with_index do |playlist_track, index|
      location = index if @currently_playing.id == playlist_track.id
    end
    @previous_track = playlist.tracks[location - 1]
  end

  def assign_next_track
    location = 0
    playlist.tracks.each.with_index do |playlist_track, index|
      location = index if @currently_playing.id == playlist_track.id
    end
    @next_track = playlist.tracks[location + 1]
  end

  def current_track_progress
    @progress = player.progress
    @track_length = @currently_playing.duration_ms
    @remaining = @track_length - @progress
  end
end
