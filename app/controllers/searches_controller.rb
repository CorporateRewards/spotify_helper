class SearchesController < ApplicationController

	def show
   	 @tracks = RSpotify::Track.search(params[:search])
	 render layout: false	
	end
end