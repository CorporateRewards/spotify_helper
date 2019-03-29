require 'rails_helper'

RSpec.describe Track do
  context 'when voting on a track' do
    let!(:current_user) { FactoryGirl.create(:user) }
    let!(:track) { Track.create(track_id: 'newtrack', metadata: 'testmetadata') }
    let!(:vote) { Vote.create(track_id: track.id, user: current_user) }

    it 'should create a vote if this is my first vote' do
      expect(track.votes.count).to eq(1)
    end

  end

  xit 'gets removed from the listings if the track is not on spotify' do

  end

  xit 'lets me search for tracks in spotify' do

  end

  xit 'lets me remove a track from the listings' do

  end

  xit 'shows me the currently playing track' do

  end

  xit 'shows me the previously played track' do

  end

  xit 'shows me the next track to be played' do

  end

  xit 'displays the title and artist of the track' do

  end

  xit 'displays the genre of the track' do

  end

  xit 'displays additional information about the track' do

  end

  xit 'adds only the top 50 tracks to the playlist' do

  end

  xit 'displays tracks in order of most tot least votes' do

  end

  xit 'lets me play and pause tracks' do

  end

  xit 'lets me generate a new playlist' do

  end
end
