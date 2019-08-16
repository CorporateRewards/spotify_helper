phrases = BannedPhrases.create(
    [
        { phrase: "admin" }, { phrase: "god" }, { phrase: "omnipotent" }, { phrase: "omniscient" }, { phrase: "nazi" }, { phrase: "hitler" }
    ]
)

# Update tracks from current playlist
playlist = RSpotify::Playlist.find(ENV['spotify_user'], ENV['spotify_playlist'])
playlist.tracks_cache.each do |playlist_track|
  track = Track.find_or_initialize_by(track_id: playlist_track.id)
  track.update!(
    name: playlist_track.name,
    artist: playlist_track.artists.map(&:name).join(', '),
    track_id: playlist_track.id,
    uri: playlist_track.uri,
    metadata: playlist_track
  )
end
