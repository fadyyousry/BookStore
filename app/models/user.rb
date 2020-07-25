class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attribute :type, default: 'Customer'
  
  has_many :sales, dependent: :nullify
  has_many :books, through: :sales 
  has_many :reviews, dependent: :destroy

  before_validation :create_customer, on: :create

  validate :has_customer_id

  def admin?
    type == "Admin"
  end

  def customer?
    type == "Customer"
  end


  private
    def has_customer_id
      if customer_id.nil?
        errors.add(:customer_id, I18n.t('messages.fail.connection_failed'))
      end
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
