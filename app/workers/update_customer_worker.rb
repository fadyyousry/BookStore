class UpdateCustomeWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find_by(id: user_id)
    unless user.nil?
      Stripe::Customer.update(
        user.customer_id,
        {email: user.email},
      )
    end
  end
end
