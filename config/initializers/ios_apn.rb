if Rails.env.production?
  IOS_APN = ENV["IOS_APN"] || Houston::Client.production

  certificate = "config/ios_production_certificate.pem"
  if File.exist? certificate
    IOS_APN.certificate = File.read(certificate)
  end

  passphrase = "config/ios_production_passphrase.txt"
  if File.exist? passphrase
    IOS_APN.passphrase = File.read(passphrase)
  end
else
  IOS_APN = ENV["IOS_APN"] || Houston::Client.development

  certificate = "config/ios_development_certificate.pem"
  if File.exist? certificate
    IOS_APN.certificate = File.read(certificate)
  end

  passphrase = "config/ios_development_passphrase.txt"
  if File.exist? passphrase
    IOS_APN.passphrase = File.read(passphrase)
  end
end
