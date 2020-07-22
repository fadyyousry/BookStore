StripeEvent.signing_secret = ENV["SIGNING_SECRET"]

StripeEvent.configure do |events|
  events.subscribe 'payment_intent.', Stripe::PaymentIntentEventHandler.new
end