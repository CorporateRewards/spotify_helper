class TracksController < ApplicationController

	def create	
		track = RSpotify::Track.find([params[:uid]])
		playlist.add_tracks!(track)
    add_track = Track.create(:name => track[0].name, :artist => track[0].artists[0].name, :track_id => track[0].id)
		redirect_to root_url
	end

	def destroy	
      track = RSpotify::Track.find([params[:uid]])
      playlist.remove_tracks!(track)
      redirect_to root_url
	end

end