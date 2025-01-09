class Domain < ApplicationRecord
  validates :domain_name, presence: true, uniqueness: true
  validates :password_expiration_date, numericality: { only_integer: true, greater_than: 0 }
end
