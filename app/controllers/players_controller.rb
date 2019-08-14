class PlayersController < ApplicationController
  def show
    Player.new(spotify_user).get_status
  end

  def update
    Player.new(spotify_user, params).update_status
    currently_playing
    player
    respond_to do |format|
      format.js
    end
  end
end
