require 'rails_helper'

RSpec.describe Nickname do
  describe 'Validations' do
    it 'doesn\'t allow banned words in nickname' do
      subject = described_class.new(nickname: 'nazi')
      expect(subject.valid?).to eq false
      expect(subject.errors.messages).to include(nickname: ['is invalid'])
    end
  end
end
