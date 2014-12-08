require 'rails_helper'

describe Todo do
  
  describe "#days_left" do
    before do
      @todo = create(:todo)
    end

    it "counts the number of days until a new todo is destroyed" do
      expect( @todo.days_left.round ).to eq(7)
    end

  end

end