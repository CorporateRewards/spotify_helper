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

    @userauth = spotify_authorized_user.sp_user_hash
    @spotify_user = RSpotify::User.new(@userauth)
  end

  def user
    return unless current_user || current_admin

    @user = current_user || User.find_by(email: current_admin.email)
  end

  def refresh_access
    return unless spotify_authorized_user

    puts 'Refreshing spotify access'

    client_id = ENV['spotify_id']
    client_secret = ENV['spotify_secret']
    authorization_token = Base64.strict_encode64("#{client_id}:#{client_secret}")
    ref_token = spotify_authorized_user.sp_user_hash['credentials'].refresh_token

    urlstring_to_post = 'https://accounts.spotify.com/api/token'
    @result = HTTParty.post(
      urlstring_to_post.to_str,
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
    spotify_authorized_user.save
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

  def current_track_progress
    @progress = player.progress
    @track_length = @currently_playing.duration_ms
    @remaining = @track_length - @progress
  end

  def current_track
    @currently_playing = player.currently_playing
    @track = Track.where(track_id: @currently_playing.id).pluck(:id)
  end

  def previous_track
    location = 0
    playlist.tracks.each.with_index do |playlist_track, index|
      location = index if @currently_playing.id == playlist_track.id
    end
    @previous_track = playlist.tracks[location - 1]
  end

  def next_track
    location = 0
    playlist.tracks.each.with_index do |playlist_track, index|
      location = index if @currently_playing.id == playlist_track.id
    end
    @next_track = playlist.tracks[location + 1]
  end

  def update_active_track
    currently_playing

    respond_to do |format|
      format.js
    end
  end

  def currently_playing
    begin
      if !spotify_user.nil?
        current_track
        previous_track
        next_track
        current_track_progress
      else
        @currently_playing = nil
      end
    rescue
      @currently_playing = nil
    end

    @votes = user.votes.where.not(track_id: nil) || nil if user

    respond_to do |format|
      format.html
      format.json { render json: @currently_playing }
      format.js
    end
  end
end
