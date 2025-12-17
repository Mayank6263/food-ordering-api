# key_id = Rails.application.credentials.dig(:razorpay, :key_id)
# secret_key = Rails.application.credentials.dig(:razorpay, :secret_key)
# Razorpay.setup(key_id, secret_key)


# Razorpay international payments gateway accepts amounts in currency subunits.
# so we will apply logic total = 100*amount 