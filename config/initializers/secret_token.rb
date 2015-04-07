# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# rubocop:disable Metrics/LineLength
WebOmni::Application.config.secret_key_base = '9a8c081e2b58e86798c4a5c3c9edc89bee56d1ea8d1af2677a08b2bccca798f1701658b99bc25efc02919bdd1ada5da414994c3d2e7850af57d41af51b6dfe06'
