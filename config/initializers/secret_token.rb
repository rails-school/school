# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if Rails.env.production?
  token = ENV['RAILS_SECRET_TOKEN']
else
  token = "6c962917b0a99394fc59a3a53a125529e8a212a084ec4dff2bb281869f5594f3b2f7b8d38a3aaf82f2dcd4c2f2f5711a56e5f3dbc2ac5ea66e61d12ddfca6d6e"
end
Rs::Application.config.secret_key_base = token
