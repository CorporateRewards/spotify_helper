class SpotifyAuthsController < ApplicationController
layout 'application-no-auth'
skip_before_action :currently_playing

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
end
