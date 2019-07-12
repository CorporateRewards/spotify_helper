require 'rspotify/oauth'

# GET https://accounts.spotify.com/authorize/?client_id=5fe01282e44241328a84e7c5cc169165&response_type=code&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=user-read-private%20user-read-email&state=34fFs29kd09
Rails.application.config.to_prepare do
  OmniAuth::Strategies::Spotify.include SpotifyOmniauthExtension
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['spotify_id'], ENV['spotify_secret'],
           scope: '
            playlist-read-private
            playlist-modify-private
            playlist-modify-public
            playlist-read-collaborative
            user-modify-playback-state
            user-read-currently-playing
            user-read-playback-state
            user-top-read
            user-read-recently-played
            app-remote-control
            streaming
            user-read-birthdate
            user-read-email
            user-read-private
            user-follow-read
            user-follow-modify
            user-library-modify
            user-library-read'
end
