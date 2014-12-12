require 'rails_helper'

RSpec.describe Todo, :type => :model do
  
  before do
    @todo = create(:todo)
  end

  context "associations" do
    it { expect(Todo.new).to belong_to(:user) }
  end

  context "validations" do
    it { expect(Todo.new).to validate_presence_of(:description) }
    it { expect(Todo.new).to ensure_length_of(:description).is_at_least(5) }
    it { expect(Todo.new).to validate_presence_of(:user_id) }
  end

  describe "#days_left" do

    it "counts the number of days until a new todo is destroyed" do
      expect( @todo.days_left.round ).to eq(7)
    end

  end
end