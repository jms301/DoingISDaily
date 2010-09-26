# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_motivation_session',
  :secret      => '9a17052bbd0ac32a1cd3c94744e0197cd5f7fabcf04f333876a5e345a0d0b9c6050d8df0086f8a13b40655bc6ec6df7deb98728479a45bd7ff3cc383fdb5613a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
