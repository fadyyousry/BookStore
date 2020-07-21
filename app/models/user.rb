class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :sales, dependent: :nullify
  has_many :books, through: :sales 
  
  attribute :type, default: 'Customer'

  before_create :create_customer

  def in_cart_books
    sales.join(:books).where(status: "In Progress")
  end

  def admin?
    type == "Admin"
  end

  def customer?
    type == "Customer"
  end

  def create_customer
    begin
      customer = Stripe::Customer.create()
      self.customer_id = customer.id
    rescue => e
      Rails.logger.debug e.message
    end
  end
end
