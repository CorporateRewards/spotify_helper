require 'rails_helper'

RSpec.describe User do
  subject { User.new(first_name: 'Gill', last_name: 'Manning', email: 'gill@createk.io', password: '12345678') }

  it 'is valid when all required fields are provided' do
    expect(subject).to be_valid
  end

  it 'is not valid without a first name' do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a last name' do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  xit 'is not valid without a nickname' do
    subject.nickname = nil
    expect(subject).to_not be_valid
  end

  it 'conforms to the email domain restrictions' do
    subject.email = 'gill@gmail.com'
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should have_one(:nickname) }
    it { should have_many(:votes) }
  end

  context 'only CR or createk emails are allowed to register' do
    let!(:valid_user) do
      User.new(
        email: 'test@createk.io',
        first_name: 'Gill',
        last_name: 'Man',
        password: '12345678'
      )
    end

    let!(:invalid_user) do
      User.new(
        email: 'gilliancorprew+rspec@gmail.com',
        first_name: 'Gill',
        last_name: 'Man',
        password: '12345678'
      )
    end

    it 'should accept emails from CR or Createk only' do
      expect(valid_user.save).to be_truthy
      expect(invalid_user.save).to be_falsey
    end
  end
end
