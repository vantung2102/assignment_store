Stripe.api_key = ENV["STRIPE_SECRET_KEY"]
Stripe.api_version = '2022-08-01'
Rails.application.configure do
  config.stripe.secret_key = ENV["STRIPE_SECRET_KEY"]
  config.stripe.publishable_key = ENV["STRIPE_PUBLISHABLE_KEY"]
end