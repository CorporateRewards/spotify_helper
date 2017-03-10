class PagesController < ApplicationController

  def index
  	@playlist = playlist    
  end

  def spotify
 	session[:sp_user] = request.env['omniauth.auth']
  	@spotify_user = spotify_user
  end


end