class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def playlist
  	@playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
  end
end
