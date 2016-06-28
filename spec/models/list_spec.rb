require 'rails_helper'

describe List do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:todos) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end
end
