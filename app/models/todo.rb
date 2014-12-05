class Todo < ActiveRecord::Base
  belongs_to :user

  validates :description, length: { minimum: 5 }, presence: true
  validates :user_id, presence: :true

after_create :update_days

private

def update_days
  self.days_left = 7
end

end
