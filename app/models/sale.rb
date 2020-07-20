class Sale < ApplicationRecord
  paginates_per 12
  belongs_to :user, required: true
  belongs_to :book, required: true

  attribute :status, default: 'In Progress', presence: true

  validates_uniqueness_of :user_id, :scope => [:book_id]

  def completed?
    status == "Completed"
  end

  def in_progress?
    status == "In Progress"
  end
end
