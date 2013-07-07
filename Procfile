web: bundle exec thin start -p $PORT -e $RACK_ENV
worker: bundle exec sidekiq -c 5 -q mailer,5 -q default
