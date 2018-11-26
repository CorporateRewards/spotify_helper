require 'rails_helper'

RSpec.describe Track do

  context 'when adding a track' do
    let!(:current_user) do
      User.create(
        email: 'test@createk.io',
        first_name: 'Gill',
        last_name: 'Man',
        password: '12345678'
      )
    end
    let!(:track) { Track.create(track_id: 'newtrack', metadata: 'testmetadata') }
    let(:new_track) { Track.create(track_id: 'newtrack') }

    it 'should allow me to add a track' do
      expect(Track.find(track.id)).to be_present
    end

    it 'does not let me add a track that has already been added' do
      expect(new_track.errors.full_messages).to include('Track has already been taken')
    end

    it 'always has metadata' do
      expect(new_track.errors.full_messages).to include('Metadata can\'t be blank')
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
