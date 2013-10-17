# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Ticket::Application.config.secret_key_base = 'a4e23ef294b43067e26802b7eaa5d8a79cde7b56dea3c425176e15cc2fed3ca4063e6f7f2ffd915fb5ca4546c71902cd2e90caffdaccdcf5a4abd552025bb6f4'
