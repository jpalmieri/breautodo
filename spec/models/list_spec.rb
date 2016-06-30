require 'rails_helper'

describe List do
  let!(:first_list)  { create(:list) }
  let!(:second_list) { create(:list) }
  let!(:third_list)  { create(:list) }
  let(:recently_updated_lists) {[second_list, third_list, first_list]}

  before { update_list(second_list) }

  def update_list(list)
    list.name = 'new name'
    list.save!
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:todos).dependent(:destroy) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
  end

  context 'when :recently_updated scope' do
    it { expect(List.recently_updated).to eq(recently_updated_lists) }
  end
end
