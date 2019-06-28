class StatsController < ApplicationController
  def show
    @top_artists = spotify_user.top_artists
  end
end
