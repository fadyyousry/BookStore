module ReviewsHelper
  def has_no_reviews?(user, book)
    user.reviews.find_by(book_id: book.id).blank?
  end
end