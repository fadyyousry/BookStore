class UpdateProductWorker
  include Sidekiq::Worker

  def perform(book_id)
    book = Book.find_by(id: book_id)
    unless book.nil?
      Stripe::Product.update(
        book.product_id,
        {
          name: book.title,
          images: [book.image_link],
          description: book.description
        },
      )
    end
  end
end
