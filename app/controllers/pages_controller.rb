class PagesController < ApplicationController
# layout 'application-no-auth'
#skip_before_action :currently_playing
# skip_before_action :spotify, 

  def index
    @playlist = playlist    
  end



end
