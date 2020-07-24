class CreateCustomerWorker
  include Sidekiq::Worker
  
  sidekiq_retries_exhausted do |msg, ex|
    user_id = msg['args'][0]
    user = User.find_by(id: user_id)
    user.destroy if user.present?
  end

  def perform(user_id)
    user = User.find_by(id: user_id)
    if user.present?
      customer = Stripe::Customer.create(email: user.email)
      user.update({customer_id: customer.id})
    end
  end
end
