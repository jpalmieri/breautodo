class List < ActiveRecord::Base
  belongs_to :user
  has_many :todos, dependent: :destroy
  scope :recently_updated, -> { order(updated_at: :desc) }

  validates :name, presence: true
  validates :user_id, presence: :true
end
