class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attribute :type, default: 'Customer'

  has_many :reviews, dependent: :destroy

  def admin?
    type == "Admin"
  end

  def customer?
    type == "Customer"
  end
end
