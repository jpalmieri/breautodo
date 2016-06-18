class Todo < ActiveRecord::Base
  belongs_to :user
  belongs_to :list, touch: true

  validates :description, presence: true
  validates :user_id, presence: :true
end
