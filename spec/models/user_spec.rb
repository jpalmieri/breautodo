require 'rails_helper'

RSpec.describe User, :type => :model do

  context "associations" do
    it { expect(User.new).to have_many(:todos) }
  end

end