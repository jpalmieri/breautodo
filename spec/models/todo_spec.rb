require 'rails_helper'

describe Todo do
  let!(:first_todo)  { create(:todo, description: 'first todo') }
  let!(:second_todo) { create(:todo, description: 'second todo') }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:list).touch(true) }
    it { is_expected.to have_many(:taggings) }
    it { is_expected.to have_many(:tags).through(:taggings) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  context 'when :newest scope' do
    it { expect(Todo.all.newest).to contain_exactly(second_todo, first_todo) }
  end
end
