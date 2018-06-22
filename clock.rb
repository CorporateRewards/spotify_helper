require File.expand_path('config/boot', File.dirname(__FILE__))
require File.expand_path('config/environment', File.dirname(__FILE__))
require 'clockwork'
require 'sidekiq'

module Clockwork
  every(1.day, 'update_playlist', :at => '22:45') do
      UpdatePlaylistWorker.perform_async
    end

    every(1.day, 'get_track_metadata', :at => '21:00') do
      GetTrackMetadataWorker.perform_async
    end
end