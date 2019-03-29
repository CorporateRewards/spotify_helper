require 'rails_helper'

RSpec.describe Track do
  context 'when adding a track' do
    let!(:current_user) { FactoryGirl.create(:user) }
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
end
