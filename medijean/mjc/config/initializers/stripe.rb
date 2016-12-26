# Set your secret key: remember to change this to your live secret key in production
# See your keys here https://manage.stripe.com/account

#Sarmad Sabih's stripe account api keys
# Stripe.api_key = "sk_test_NxgSn4N8N3NdDrrxWmjxSCgb"
# STRIPE_PUBLIC_KEY = 'pk_test_PorlyTiDJMoOYe2h36rWRhIg'

stripe_config = YAML.load_file("#{Rails.root}/config/stripe.yml")[Rails.env]
Stripe.api_key = stripe_config["api_key"]
STRIPE_PUBLIC_KEY = stripe_config["stripe_public_key"]