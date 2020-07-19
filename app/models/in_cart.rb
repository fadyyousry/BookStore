class InCart < ApplicationRecord
  belongs_to :user
  belongs_to :book

  attribute :status, default: 'In Progress'

  validates_uniqueness_of :user_id, :scope => [:book_id]

  def completed?
    type == "Completed"
  end

  def in_progress?
    type == "In Progress"
  end

end
