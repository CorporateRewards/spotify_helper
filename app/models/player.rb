class Player
  def initialize(user, params = nil)
    @player = user.player
    @activity = params[:activity] if params.present?
    @playlist = params[:playlist] if params.present?
    @direction = params[:direction] if params.present?
    @volume_change = params[:change] if params.present?
  end

  def update_status
    self.send(@activity)
  end

  def get_status
    @playlist ||= RSpotify::Playlist.find(ENV['spotify_user'], ENV['spotify_playlist'])
    current_track
    previous_track
    next_track
  end

  private

  def play_tracks
    @player.play_context(device_id = nil, @playlist)
  end

  def pause_tracks
    @player.pause
  end

  def play_individual_track
    @player.play_track(params[:track])
  end

  def change_volume
    volume = @player.instance_variable_get(:@device).instance_variable_get(:@volume_percent).to_i
    volume = (@volume_change == '1') ? volume + 10 : volume - 10
    @player.volume(volume)
  end

  def navigate
    @player.next if @direction == 'next'
    @player.previous if @direction == 'previous'
  end

  def current_track
    @currently_playing = @player.currently_playing
    @track = Track.where(track_id: @currently_playing.id).pluck(:id)
    @current_track = Track.where(track_id: @currently_playing.id)
  end

  def previous_track
    location = 0
    @playlist.tracks.each.with_index do |playlist_track, index|
      location = index if @currently_playing.id == playlist_track.id
    end
    @previous_track = @playlist.tracks[location - 1]
  end

  def next_track
    location = 0
    @playlist.tracks.each.with_index do |playlist_track, index|
      location = index if @currently_playing.id == playlist_track.id
    end
    @next_track = @playlist.tracks[location + 1]
  end
end
