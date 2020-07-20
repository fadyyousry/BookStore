class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :sales
  has_many :books, through: :sales
  
  enum status: [ :in_progress, :completed ]
  attribute :type, default: 'Customer'

  before_create :create_customer

  def admin?
    type == "Admin"
  end

  def customer?
    type == "Customer"
  end

  def create_customer
    customer = Stripe::Customer.create()
    self.customer_id = customer.id
  end
end
