class Group < ApplicationRecord
  belongs_to :user
  has_many :contacts

  validates :name, presence: true, length: { maximum: 50 }
end
