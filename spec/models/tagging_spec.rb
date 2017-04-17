require 'rails_helper'

RSpec.describe Tagging, :type => :model do
  let!(:first_tagging)  { create(:tagging) }

  describe 'associations' do
    it { is_expected.to belong_to(:todo) }
    it { is_expected.to belong_to(:tag) }
  end
end
