class PagesController < ApplicationController
layout 'application-no-auth'
skip_before_filter :currently_playing
  def index
    @playlist = playlist    
  end



end
