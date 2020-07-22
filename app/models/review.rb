class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment, presence: true
  validates :book_id, uniqueness: {scope: :user_id}
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
end