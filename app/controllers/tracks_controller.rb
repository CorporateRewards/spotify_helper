class TracksController < ApplicationController

	def create	
		track = RSpotify::Track.find([params[:uid]])
		playlist.add_tracks!(track)
		redirect_to root_url
	end

	def destroy	
      track = RSpotify::Track.find([params[:uid]])
      playlist.remove_tracks!(track)
      redirect_to root_url
	end

end