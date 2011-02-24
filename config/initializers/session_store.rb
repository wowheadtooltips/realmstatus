# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_realmstatus_session',
  :secret      => '453acf74e2778faa630ae9b74be38501c41399ede358824e25738470dc2e85003e9888b87c8bffe9125891e1efd000afce91f28963e1550cfaa47f2f4c62a7fd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
