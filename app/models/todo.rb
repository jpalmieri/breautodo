class Todo < ActiveRecord::Base
  belongs_to :user

validates :description, length: { minimum: 5 }, presence: true

end
