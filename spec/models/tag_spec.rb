require 'rails_helper'

RSpec.describe Tag, :type => :model do
  let!(:first_tag)  { create(:tag, name: 'first_tag') }

  describe 'associations' do
    it { is_expected.to have_many(:taggings) }
    it { is_expected.to have_many(:todos).through(:taggings) }
  end
end
