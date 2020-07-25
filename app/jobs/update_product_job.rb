class UpdateProductJob < ApplicationJob

  def perform(book)
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
