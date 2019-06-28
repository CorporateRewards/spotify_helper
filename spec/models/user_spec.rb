require 'rails_helper'

RSpec.describe User do
  it 'is valid when all required fields are provided' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without a first name' do
    user = build(:user, first_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is not valid without a last name' do
    user = build(:user, last_name: nil)
    expect(user).to_not be_valid
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is not valid without an email' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'is not valid without a password' do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end

  xit 'is not valid without a nickname' do
    user = build(:user, nickname: nil)
    expect(user).to_not be_valid
    expect(user.errors[:nickname]).to include("can't be blank")
  end

  it 'conforms to the email domain restrictions' do
    user = build(:user, email: 'gill@gmail.com')
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("You must register with a corporaterewards.co.uk address")
  end

  it 'is not valid with a duplicate email address' do
    existing_user = create(:user, email: 'gill@createk.io')
    new_user = build(:user, email: 'gill@createk.io')
    expect(new_user).to_not be_valid
    expect(new_user.errors[:email]).to include('has already been taken')
  end

  describe 'Associations' do
    it { should have_one(:nickname) }
    it { should have_many(:votes) }
  end
end
