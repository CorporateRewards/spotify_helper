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

  def spotify_user
    return unless SpotifyAuth.last

    # refresh_access
    user_auth = SpotifyAuth.last
    @userauth = user_auth.sp_user_hash
    @spotify_user = RSpotify::User.new(@userauth)
  end

  def user
    return unless current_user || current_admin

    @user = current_user || User.find_by(email: current_admin.email)
  end

  def refresh_access
    return unless SpotifyAuth.last

    client_id = ENV['spotify_id']
    client_secret = ENV['spotify_secret']
    @baseuser = Base64.strict_encode64("#{client_id}:#{client_secret}")
    @user_auth = SpotifyAuth.last
    @ref_token = @user_auth.sp_user_hash['credentials'].refresh_token

    @urlstring_to_post = 'https://accounts.spotify.com/api/token'
    @result = HTTParty.post(
      @urlstring_to_post.to_str,
      body: {
        grant_type: 'refresh_token',
        refresh_token: @ref_token
      },
      headers: {
        'Authorization' => 'Basic ODljNWFiYjA1YmQ0NDRlZGE3OThhZTJjMTVjY2I5MjE6N2I5YWJiMjNhZjhjNGRlM2E0NjQyZGE5MzcwN2M4MTU='
      }
    )
    @user_auth.sp_user_hash['credentials'].token = @result['access_token']
    @user_auth.save
  end

  def track_progress
    @progress = spotify_user.player.progress
    respond_to do |format|
      format.json { render json: @progress }
    end
  end

  def player
    @player = spotify_user.player
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

  def currently_playing
    begin
      if !spotify_user.nil?
        current_track
        previous_track
        next_track
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
