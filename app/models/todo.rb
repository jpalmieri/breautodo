class Todo < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates :description, length: { minimum: 5 }, presence: true
  validates :user_id, presence: :true
end
