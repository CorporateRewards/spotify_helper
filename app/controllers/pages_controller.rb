class PagesController < ApplicationController
layout 'application-no-auth'
# skip_before_action :currently_playing

  def index
    @playlist = playlist    
  end



end
