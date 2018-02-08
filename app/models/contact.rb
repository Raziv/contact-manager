class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum:255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true,
                    case_sensitive: false
  validates :phone, presence: true, numericality: true,
            length: { minimum: 10, maximum: 15 }
end
