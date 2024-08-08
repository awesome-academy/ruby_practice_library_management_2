class BorrowRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :by_status, ->(status){where(status: status) if status.present?}
  scope :ordered, ->{order(created_at: :desc)}

  validates :user_id, :book_id, :start_date, :end_date, presence: true

  enum status: {pending: 0, approved: 1, rejected: 2, canceled: 3}

  validates :status, inclusion: {in: statuses.keys}

  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return unless end_date < start_date

    errors.add(:end_date, "phải sau ngày bắt đầu.")
  end
end
