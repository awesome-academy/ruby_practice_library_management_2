class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher
  belongs_to :category
  has_many :borrow_requests, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :author_id, :publisher_id, :category_id, presence: true
  validates :description, presence: true
  validates :published_date, presence: true, if: ->{published_date.present?}
  validates :rental_price, numericality: {greater_than_or_equal_to: 0},
             allow_nil: true
end
