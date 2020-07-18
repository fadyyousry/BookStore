class BillsController < ApplicationController

  def new
    set_book
    set_product 
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [
        price_data: {
          product: @product.id,
          unit_amount: (@book.price * 100).to_i,
          currency: 'usd',
        },
        quantity: 1,
      ],
      mode: 'payment',
      success_url: books_url,
      cancel_url: book_url(@book.id),
    })
    respond_to do |format|
      format.js
    end
  end

  private
    def set_book
      @book = Book.find(params[:book])
    end

    def set_product
      if @book.product_id.nil?
        @product = Stripe::Product.create({
                    name: @book.title,
                    images: [@book.image_link],
                    description: @book.description
                  })
        @book.update(product_id: @product.id)
      else
        @product = Stripe::Product.retrieve(@book.product_id)
      end
    end

end
