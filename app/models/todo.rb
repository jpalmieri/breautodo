class Todo < ActiveRecord::Base
  belongs_to :user
  belongs_to :list, touch: true
  has_many :taggings
  has_many :tags, through: :taggings
  scope :newest, -> { order(created_at: :desc) }

  validates :description, presence: true
  validates :user_id, presence: :true
  validates :list_id, presence: true
end
