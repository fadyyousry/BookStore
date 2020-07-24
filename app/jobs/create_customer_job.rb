class CreateCustomerJob < ApplicationJob
  queue_as :default

  def perform(user)
    customer = Stripe::Customer.create({email: user.email})
    user.update({customer_id: customer.id})
  end
end
