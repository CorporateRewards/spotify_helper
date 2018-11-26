require 'rails_helper'

RSpec.describe User do
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
