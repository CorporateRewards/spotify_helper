class GetTrackMetadataWorker
  include Sidekiq::Worker

  def perform
    tracks = Track.where(:metadata => nil).pluck(:track_id)
    tracks.each do |track_id|
      puts track_id
      spotify_track = RSpotify::Track.find(track_id)
      track = Track.where(:track_id => track_id).first
      track.uri = spotify_track.uri
      track.metadata = spotify_track
      track.save
    end
  end
end
