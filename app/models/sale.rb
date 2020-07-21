class Sale <  ActiveRecord::Base
  paginates_per 12
  belongs_to :user, required: true
  belongs_to :book, required: true

  enum status: [ :in_progress, :completed ]
  attribute :status, default: :in_progress, presence: true

  validates_uniqueness_of :user_id, :scope => [:book_id]
end
