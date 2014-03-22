class GroupSerializer < ActiveModel::Serializer
  attributes :id, :title, :sort_order, :created_at
end
