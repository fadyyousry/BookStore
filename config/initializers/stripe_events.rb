StripeEvent.signing_secret = Rails.application.credentials.stripe[Rails.env.to_sym][:signing_secret]

StripeEvent.configure do |events|
  events.subscribe 'payment_intent.', Stripe::PaymentIntentEventHandler.new
end