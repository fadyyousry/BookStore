class UpdateCustomerJob < ApplicationJob
  queue_as :default

  def perform(user)
    Stripe::Customer.update(
      user.customer_id,
      {email: user.email},
    )
  end
end
