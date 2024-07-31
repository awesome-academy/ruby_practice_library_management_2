class User < ApplicationRecord
  has_many :borrow_requests, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  enum role: {guest: 0, admin: 1}

  validates :role, inclusion: {in: roles.keys}
end
