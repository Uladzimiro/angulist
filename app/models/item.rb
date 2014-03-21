class Item < ActiveRecord::Base
  belongs_to :group

  validates :group_id, :title, presence: true
end
