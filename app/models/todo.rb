class Todo < ActiveRecord::Base
  belongs_to :user
  belongs_to :list, touch: true
  has_many :taggings
  has_many :tags, through: :taggings
  scope :newest, -> { order(created_at: :desc) }

  validates :description, presence: true
  validates :user_id, presence: :true
  validates :list_id, presence: true

  before_save :add_tags_from_description

  def add_tags_from_description
    tag_regex = /(?:|^)(?:#(?!.\d+(?:\s|$)))(\w+)(?=\s|$)/i
    names = self.description.scan(tag_regex).flatten
    self.tags = names.map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
end
