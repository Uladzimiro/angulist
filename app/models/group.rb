class Group < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :title, presence: true
  validates :title, length: { maximum: 30 }
end
