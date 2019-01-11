require 'rails_helper'

RSpec.describe Track do

  context 'when voting on a track' do
    let!(:current_user) do
      User.create(
        email: 'test@createk.io',
        first_name: 'Gill',
        last_name: 'Man',
        password: '12345678'
      )
    end
    let!(:track) { Track.create(track_id: 'newtrack', metadata: 'testmetadata') }
    let!(:vote) { Vote.create(track_id: track.id, user: current_user) }

    it 'should create a vote if this is my first vote' do
      expect(track.votes.count).to eq(1)
    end

  end

  it 'gets removed from the listings if the track is not on spotify' do

  end

  it 'lets me search for tracks in spotify' do

  end

  it 'lets me remove a track from the listings' do

  end

  it 'shows me the currently playing track' do

  end

  it 'shows me the previously played track' do

  end

  it 'shows me the next track to be played' do

  end

  it 'displays the title and artist of the track' do

  end

  it 'displays the genre of the track' do

  end

  it 'displays additional information about the track' do

  end

  it 'adds only the top 50 tracks to the playlist' do

  end

  it 'displays tracks in order of most tot least votes' do

  end

  it 'lets me play and pause tracks' do

  end

  it 'lets me generate a new playlist' do

  end
end
