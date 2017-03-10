class TracksController < ApplicationController

	def create
		track = RSpotify::Track.find([params[:uid]])
		playlist.add_tracks!(track)




	end

end