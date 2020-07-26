module Stripe
  class CheckoutSessionEventHandler
    def call(event)
      begin
        method = "handle_" + event.type.tr('.', '_')
        send method, event
      rescue JSON::ParserError => e
        Rails.logger.debug e.message
      rescue NoMethodError => e
        Rails.logger.debug e.message
      end
    end
    
    private
      def handle_checkout_session_completed(event)
        @payment = Stripe::PaymentIntent.retrieve(event[:data][:object][:payment_intent])
        customer_id = @payment[:charges][:data][0][:customer]
        @user = User.find_by(customer_id: customer_id)
        change_sales_status(event)
        send_receipt_email(event) if @user.present?
      end

      def change_sales_status(event)
        line_items = Stripe::Checkout::Session.list_line_items(event[:data][:object][:id])
        items = line_items[:data]
        items.each do |item|
          product_id = item[:price][:product]
          book = @user.books.find_by(product_id: product_id)
          @user.sales.find_by(book_id: book.id).completed!
        end
      end

      def send_receipt_email(event)
        receipt_url = @payment[:charges][:data][0][:receipt_url]
        UserMailer.with(user: @user, url: receipt_url).receipt_email.deliver_later
      end
  end
end