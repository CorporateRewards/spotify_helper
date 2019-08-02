class PlayersController < ApplicationController
  def update
    Player.new(spotify_user, params).update_status
  end
end
