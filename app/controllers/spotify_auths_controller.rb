class SpotifyAuthsController < ApplicationController
layout 'application-no-auth'
skip_before_action :currently_playing

end
