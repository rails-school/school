if Rails.env.production?
  IOS_APN = ENV['IOS_APN'] || Houston::Client.production
  IOS_APN.certificate = File.read('config/ios_production_certificate.txt')
  IOS_APN.passphrase = File.read('config/ios_production_passphrase.txt')
else
  IOS_APN = ENV['IOS_APN'] || Houston::Client.development
  IOS_APN.certificate = File.read('config/ios_development_certificate.txt')
  IOS_APN.passphrase = File.read('config/ios_development_passphrase.txt')
end