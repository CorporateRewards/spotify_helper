require 'rails_helper'

RSpec.describe Track do
  context 'when adding a track' do
    let!(:current_user) { create(:user) }
    let!(:track) { create(:track, track_id: 'newtrack') }
    let(:duplicate_track) { build(:track, track_id: 'newtrack') }
    let(:no_metadata_track) { build(:track, metadata: nil) }

    it 'should allow me to add a track' do
      expect(Track.find(track.id)).to be_present
    end

    it 'does not let me add a track that has already been added' do
      expect(duplicate_track).to_not be_valid
      expect(duplicate_track.errors.full_messages).to include('Track has already been taken')
    end

    it 'always has metadata' do
      expect(no_metadata_track).to_not be_valid
      expect(no_metadata_track.errors.full_messages).to include('Metadata can\'t be blank')
    end
  end
end
