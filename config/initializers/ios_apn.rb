if Rails.env.production?
  IOS_APN = ENV["IOS_APN"] || Houston::Client.production
  IOS_APN.certificate = ENV["IOS_PRODUCTION_CERTIFICATE"]
  IOS_APN.passphrase = ENV["IOS_PRODUCTION_PASSPHRASE"]
else
  IOS_APN = ENV["IOS_APN"] || Houston::Client.development
  IOS_APN.certificate = ENV["IOS_DEVELOPMENT_CERTIFICATE"]
  IOS_APN.passphrase = ENV["IOS_DEVELOPMENT_PASSPHRASE"]
end