
class UpdatePlaylistWorker
  include Sidekiq::Worker

  def perform
    user_auth = SpotifyAuth.last
    @userauth = user_auth.sp_user_hash
    @spotify_user = RSpotify::User.new(@userauth)
    @alltracks = Track.made_the_playlist
    if !@alltracks.empty?
      if @alltracks.length < 100
        @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
        @playlist.replace_tracks!(@alltracks.flatten)
      else
        @first_100_tracks = @alltracks.first(100)
        @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
        @playlist.replace_tracks!(@first_100_tracks.flatten)
        length = @alltracks.length - 100
        @additional = @alltracks.last(length)

        @additional.each do |t|
          @playlist.add_tracks!(t)          
      end
    end
  end
end
end