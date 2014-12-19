require 'rails_helper'

describe User do

  context "associations" do
    it { expect(User.new).to have_many(:todos) }
  end

  context "validations" do
    it { expect(User.new).to validate_presence_of(:auth_token) }
  end

  context "has auth_token" do
    it "adds an auth_token to new user" do
      user = build(:user)
      expect(user.auth_token).to be_nil
      user.save!
      expect(user.auth_token).to match(/\A[a-zA-Z0-9_-]{20}\z/)
    end

    it "calls Devise.friendly_token on user#create" do
      user = build(:user)
      expect(user.auth_token).to be_nil

      expect(Devise).to receive(:friendly_token).and_return "some-secret-token"

      user.save!
      expect(user.auth_token).to eq("some-secret-token")
    end
  end
end