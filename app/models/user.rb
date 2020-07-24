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
    CreateCustomerWorker.perform_async self.id
  end

  def update_customer
    UpdateCustomerWorker.perform_async self.id
  end
end
