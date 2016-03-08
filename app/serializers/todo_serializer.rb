class TodoSerializer < ActiveModel::Serializer
  attributes :id, :description, :list_id
end
