class Player
  def initialize(user, params = nil)
    @player = user.player
    @activity = params[:activity]
    @playlist = params[:playlist]
    @direction = params[:direction] if params.present?
    @volume_change = params[:change] if params.present?
  end

  def update_status
    self.send(@activity)
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
end
