# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Angulist::Application.config.secret_key_base = ENV['SECRET_KEY'] || '121dfa55898aa7c766ee866d5b66f54d617db5555555555690845ff44310de853226e7ff9739cae326387257a918553cf8a2b30e9332a3ffd9c34c4459285cb1'
