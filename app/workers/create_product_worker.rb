class CreateProductWorker
  include Sidekiq::Worker

  sidekiq_retries_exhausted do |msg, ex|
    book_id = msg['args'][0]
    book = Book.find_by(id: book_id)
    book.destroy if book.present?
  end

  def perform(book_id)
    book = Book.find_by(id: book_id)
    if book.present?
      product = Stripe::Product.create({
                  name: book.title,
                  images: [book.image_link],
                  description: book.description
                })
      book.update({product_id: product.id})
    end
  end
end
