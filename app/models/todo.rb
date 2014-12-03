class Todo < ActiveRecord::Base

validates :description, length: { minimum: 5 }, presence: true

end
