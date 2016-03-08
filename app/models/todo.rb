class Todo < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates :description, length: { minimum: 5 }, presence: true
  validates :user_id, presence: :true

def days_left
  @expiration_date = self.created_at + 7.days
  @days_until_expiration = (@expiration_date - Time.now) / (60*60*24)
end

end
