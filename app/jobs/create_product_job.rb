class CreateProductJob < ApplicationJob

  def perform(book)
    product = Stripe::Product.create({
                name: book.title,
                images: [book.image_link],
                description: book.description
              })
    book.update({product_id: product.id})
  end
end
