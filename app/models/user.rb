class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attribute :type, default: 'Customer'
  
  has_many :sales, dependent: :nullify
  has_many :books, through: :sales 
  has_many :reviews, dependent: :destroy

  after_create :create_customer
  after_update :update_customer

  def admin?
    type == "Admin"
  end

  def customer?
    type == "Customer"
  end

  def create_customer
    CreateCustomerJob.perform_later self
  end

  def update_customer
    UpdateCustomerJob.perform_later self
  end
end
