require 'rails_helper'

describe Todo do
  let!(:first_todo)  { create(:todo, description: 'first todo') }
  let!(:second_todo) { create(:todo, description: 'second todo') }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:list).touch(true) }
  end

  context 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:user_id) }
  end

  context 'when :newest scope' do
    it { expect(Todo.all.newest).to contain_exactly(second_todo, first_todo) }
  end
end
