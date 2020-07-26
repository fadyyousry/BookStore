StripeEvent.signing_secret = ENV["SIGNING_SECRET"]

StripeEvent.configure do |events|
  events.subscribe 'checkout.session.', Stripe::CheckoutSessionEventHandler.new
end