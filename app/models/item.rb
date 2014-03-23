class Item < ActiveRecord::Base
  belongs_to :group

  validates :group_id, :title, presence: true
  validates :title, length: { maximum: 50 }

end
