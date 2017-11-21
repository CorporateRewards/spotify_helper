require 'rspotify/oauth'

# GET https://accounts.spotify.com/authorize/?client_id=5fe01282e44241328a84e7c5cc169165&response_type=code&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=user-read-private%20user-read-email&state=34fFs29kd09

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_id"], ENV["spotify_secret"], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify playlist-modify-private user-top-read user-read-currently-playing user-read-playback-state user-read-recently-played user-modify-playback-state'
end


