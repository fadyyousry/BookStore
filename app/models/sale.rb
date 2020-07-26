class Sale <  ActiveRecord::Base
  paginates_per 10
  belongs_to :user, required: true
  belongs_to :book, required: true
  
  attribute :status, default: :in_progress, presence: true
  enum status: [ :in_progress, :completed ]

  validates_uniqueness_of :user_id, :scope => [:book_id]
end
