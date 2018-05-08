class ApplicationController < ActionController::Base
  require 'httparty'
  require 'base64'
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :currently_playing

  def playlist
    @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
  end

  def authenticate_user!(*args)
    if admin_signed_in?
      return
    end
    super
  end

  def spotify_user
    if SpotifyAuth.last
      # refresh_access
      user_auth = SpotifyAuth.last
      @userauth = user_auth.sp_user_hash
      @spotify_user = RSpotify::User.new(@userauth)
    end
  end

  def refresh_access
    if SpotifyAuth.last
      client_id = ENV["spotify_id"]
      client_secret = ENV["spotify_secret"]
      @baseuser = Base64.strict_encode64("#{client_id}:#{client_secret}")
      @user_auth = SpotifyAuth.last
      @ref_token = @user_auth.sp_user_hash["credentials"].refresh_token

      @urlstring_to_post = "https://accounts.spotify.com/api/token"
      @result = HTTParty.post(@urlstring_to_post.to_str, 
        :body => { 
          :grant_type => "refresh_token", 
          :refresh_token => @ref_token
        },
        :headers => { 'Authorization' => 'Basic ODljNWFiYjA1YmQ0NDRlZGE3OThhZTJjMTVjY2I5MjE6N2I5YWJiMjNhZjhjNGRlM2E0NjQyZGE5MzcwN2M4MTU=' })
      @user_auth.sp_user_hash["credentials"].token = @result["access_token"]
      @user_auth.save
  end
  end

  def currently_playing
    begin
      if !spotify_user.nil?
        @player = spotify_user.player
        @currently_playing = @player.currently_playing
      else
        @currently_playing = nil
      end
    rescue
      @currently_playing = nil
    end
  end

end
