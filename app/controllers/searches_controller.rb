class SearchesController < ApplicationController

	def show
    @offset = params[:offset] ? params[:offset] : 0
   	@tracks = RSpotify::Track.search(params[:search], limit: 10 , offset: @offset )
    render layout: false	
	end

end