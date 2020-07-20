class BillsController < ApplicationController

  def new
    begin
      @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        customer: current_user.customer_id,
        line_items: get_line_items,
        mode: 'payment',
        success_url: books_url,
        cancel_url: sales_url,
      })
    rescue => e
      Rails.logger.debug e.message
    end
    respond_to do |format|
      format.js
    end
  end

  private
    def sales_ids
      params.require(:sales)
    end

    def get_books
      books = []
      sales_ids.each do |id|
        book = Book.find(Sale.find(id).book_id)
        books.append(book)
      end
      books
    end

    def get_line_items
      line_items = []
      get_books.each do |book|
        item = Hash.new
        item[:price_data] = Hash.new
        item[:price_data][:product] = book.product_id
        item[:price_data][:unit_amount] = (book.price * 100).to_i
        item[:price_data][:currency] = 'usd'
        item[:quantity] = 1
        line_items.append(item)
      end
      line_items
    end

end
