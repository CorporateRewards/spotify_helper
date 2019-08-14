class UpdatePlaylistWorker
  include Sidekiq::Worker

  def perform
    return if tracks_to_be_added.empty?

    initiate_rspotify_user
    initiate_playlist
    @playlist.replace_tracks!(tracks_to_be_added.flatten)
  end

  private

  def tracks_to_be_added
    Track.top_voted_tracks + Track.recently_added_tracks
  end

  def initiate_rspotify_user
    RSpotify::User.new(SpotifyAuth.last.sp_user_hash)
  end

  def initiate_playlist
    @playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
  end
end
