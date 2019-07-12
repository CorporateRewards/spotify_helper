class UpdatePlaylistWorker
  include Sidekiq::Worker

  def perform
    return if tracks_to_be_added.empty?

    playlist = RSpotify::Playlist.find('crtechteam', '5esgCdY5baXWpIrPHs5ZYp')
    playlist.replace_tracks!(tracks_to_be_added.flatten)
  end

  def tracks_to_be_added
    Track.top_voted_tracks + Track.recently_added_tracks
  end
end
