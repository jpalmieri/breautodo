require 'rails_helper'

describe List do

  before do
    @list = create(:list)
    5.times do
      create(:todo, list: @list)
    end
  end

  context 'associations' do
    it { expect(List.new).to belong_to(:user) }
    it { expect(List.new).to have_many(:todos) }
  end

  context "validations" do
    it { expect(List.new).to validate_presence_of(:name) }
    it { expect(List.new).to validate_presence_of(:user_id) }
  end


end
