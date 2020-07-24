class BillsController < ApplicationController
  before_action :authorize_checkout, :new
  
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
    rescue Stripe::APIConnectionError => e
      Rails.logger.debug e.message
    rescue ActionController::ParameterMissing => e
      redirect_to sales_url(cart: true), notice: t('default.messages.no_item')
    end
    respond_to do |format|
      format.js
    end
  end
  
  private
    def products_params
      params.require(:products).map {|product| product.permit(:product_id, :price)}
    end
    
    def authorize_checkout
      authorize! :create, Sale
    end
    
    def get_line_items
      products_params.map do |product|
        create_item product
      end
    end

    def create_item product
      item = Hash.new
      item[:price_data] = Hash.new
      item[:price_data][:product] = product[:product_id]
      item[:price_data][:unit_amount] = price_in_cents(product[:price])
      item[:price_data][:currency] = 'usd'
      item[:quantity] = 1
      item
    end

    def price_in_cents price
      (price.to_f * 100).to_i
    end

end
