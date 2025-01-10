class Domain < ApplicationRecord
  has_many :mailboxes, dependent: :destroy

  validates :domain_name, presence: true, uniqueness: true
  validates :password_expiration_frequency, numericality: { only_integer: true, greater_than: 0 }
end
