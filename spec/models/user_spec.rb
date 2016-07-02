require 'rails_helper'

describe User do
  let(:user) { build(:user) }

  context 'associations' do
    it { is_expected.to have_many(:todos).dependent(:destroy) }
    it { is_expected.to have_many(:lists).dependent(:destroy) }
  end

  context 'has auth_token' do
    it 'adds an auth_token to new user' do
      expect(user.auth_token).to be_nil
      user.save!
      expect(user.auth_token).to match(/\A[a-zA-Z0-9_-]{20}\z/)
    end

    it 'calls Devise.friendly_token on user#create' do
      expect(user.auth_token).to be_nil
      expect(Devise).to receive(:friendly_token).and_return 'some-secret-token'
      user.save!
      expect(user.auth_token).to eq('some-secret-token')
    end

    it 'returns error when auth token is removed from user' do
      user.save!
      user.auth_token = nil
      user.valid?
      expect(user.errors.full_messages).to eq(['Auth token can\'t be blank'])
    end
  end
end
