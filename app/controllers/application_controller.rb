class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authenticate_user!

  before_filter :currently_playing

  def playlist
  	@playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
  end

  def spotify_user
  	RSpotify::User.new(session[:sp_user])
  end

  def currently_playing
      @currently_playing = spotify_user.currently_playing
  end
end
