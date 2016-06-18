require 'rails_helper'

describe Todo do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:list).touch(true) }
  end

  context 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
  end
end
