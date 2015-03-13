desc "Heroku scheduler file"

task clean_spam: :environment do
  SpamCatcher.perform_async
end
