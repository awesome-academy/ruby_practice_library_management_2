class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :borrow_requests, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  enum role: {guest: 0, member: 1, admin: 2}

  validates :role, inclusion: {in: roles.keys}
end
