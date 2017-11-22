class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!

  before_action :currently_playing

  def playlist
    @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
  end


  def spotify
    session[:sp_user] = request.env['omniauth.auth']
    suser = RSpotify::User.new(session[:sp_user])
    user_hash = suser.to_hash
    spotify_auth = SpotifyAuth.create(:sp_user_hash => user_hash)
    @spotify_user = suser
    user_auth = SpotifyAuth.last
    @userauth = user_auth.sp_user_hash
    redirect_to root_url
  end

  def spotify_user
    # user_auth = SpotifyAuth.last
    # @userauth = user_auth.sp_user_hash
    RSpotify::User.new(session[:sp_user])
  end

  def currently_playing
      @currently_playing = spotify_user.currently_playing
  end

end