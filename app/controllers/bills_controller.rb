class BillsController < ApplicationController
  before_action :set_book, :set_customer, only: [:create]

  def new
    respond_to do |format|
      format.js
    end
  end

  def create()
    Stripe::Charge.create({
      customer: @customer.id,
      amount: (@book.price * 100).to_i,
      description: @book.title,
      currency: 'usd',
    })
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @book
  end

  private
    def set_customer
      if current_user.stripe_id.nil?
        @customer = Stripe::Customer.create({email: params[:stripeEmail]})
        current_user.update(:stripe_id => @customer.id)
      else
        @customer = Stripe::Customer.retrieve current_user.stripe_id
      end
      @customer.source = params[:stripeToken]
      @customer.save
    end

    def set_book
      @book = Book.find(params[:book])
    end

end
