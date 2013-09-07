web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -c 5 -q mailer,5 -q default
console: script/rails console
