class Mailbox < ApplicationRecord
  belongs_to :domain

  validates :username, presence: true, uniqueness: { scope: :domain_id }
  validates :password, presence: true, format: { with: /\A.{8,}\z/ }
  validates :scheduled_password_expiration, presence: true
end
