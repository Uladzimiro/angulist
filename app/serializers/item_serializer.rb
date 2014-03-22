class ItemSerializer < ActiveModel::Serializer
  attributes :id, :group_id, :title, :priority, :complete_on, :completed, :sort_order, :created_at
end
