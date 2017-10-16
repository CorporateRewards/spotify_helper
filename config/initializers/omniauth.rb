require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["spotify_id"], ENV["spotify_secret"], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify playlist-modify-private user-top-read user-read-currently-playing user-read-playback-state user-read-recently-played'
end