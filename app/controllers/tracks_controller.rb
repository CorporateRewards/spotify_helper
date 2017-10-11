class TracksController < ApplicationController

  def create
        track = RSpotify::Track.find([params[:uid]])
        playlist.add_tracks!(track)
        add_track = Track.create(:name => track[0].name, :artist => track[0].artists[0].name, :track_id => track[0].id)
        track_id = Track.where(track_id: track[0].id).first
        track_id.votes.create(vote: params[:vote])
        redirect_to root_url
    end

    def show
        thisQuery = File.read(Rails.root.join('db', 'queries', 'tuneUp_topVotedTracks.sql').to_s).to_s
        @playlist = ActiveRecord::Base.connection.execute(thisQuery)
        @currently_playing = spotify_user.currently_playing
        date = DateTime.parse(spotify_user.currently_playing.album.release_date)
        @released_date = date.strftime('%b %d %Y')      
    end

    def destroy
        track = RSpotify::Track.find([params[:uid]])
        playlist.remove_tracks!(track)
        redirect_to root_url
    end

end