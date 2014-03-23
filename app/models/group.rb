class Group < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :user_id, :title, presence: true
  validates :title, length: { maximum: 30 }
end
