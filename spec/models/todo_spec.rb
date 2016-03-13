require 'rails_helper'

describe Todo do

  before do
    @todo = create(:todo)
  end

  describe Todo do
    it { expect(Todo.new).to belong_to(:user) }
    it { expect(Todo.new).to belong_to(:list).touch(true) }
  end

  context "validations" do
    it { expect(Todo.new).to validate_presence_of(:description) }
    it { expect(Todo.new).to ensure_length_of(:description).is_at_least(5) }
    it { expect(Todo.new).to validate_presence_of(:user_id) }
  end
end
