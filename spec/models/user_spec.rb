require 'rails_helper'

describe User do

  context "associations" do
    it { expect(User.new).to have_many(:todos) }
  end

  context "validations" do
    it { expect(User.new).to validate_presence_of(:auth_token) }
  end

end