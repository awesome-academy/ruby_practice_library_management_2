class BorrowRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, :book_id, :start_date, :end_date, presence: true

  enum status: {pending: 0, approved: 1, rejected: 2}

  validates :status, inclusion: {in: statuses.keys}
end
