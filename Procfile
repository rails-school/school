web: bundle exec rails server thin -p $PORT -e $RACK_ENV
worker: bundle exec sidekiq -q mailer,5 -q default
