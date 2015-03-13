class SpamCatcher
  include Sidekiq::Worker
  # This job is to check any emails in Sendgrid that are flagged as spam.
  SENDGRID_USERNAME = ENV["SENDGRID_USERNAME"]
  SENDGRID_PASSWORD = ENV["SENDGRID_PASSWORD"]
  POST_URL = "https://api.sendgrid.com/api/spamreports.delete.json"
  GET_URL = "https://api.sendgrid.com/api/spamreports.get.json?" \
            "api_user=#{SENDGRID_USERNAME}&" \
            "api_key=#{SENDGRID_PASSWORD}&date=1"

  def perform
    process_spam_reports
  end

  private

  def process_spam_reports
    response = HTTParty.get(GET_URL)
    if response.code == 200
      spam_reports = JSON.parse(response.parsed_response)
      spam_reports.each { |report| delete_spam_report(report["email"]) }
    end
  end

  def delete_spam_report(email)
    post_params = { api_user: SENDGRID_USERNAME,
                    api_key: SENDGRID_PASSWORD }
    result = HTTParty.post(POST_URL,
                           query: post_params.merge!( email: email ) )
    logger.info("Got spam report for #{email}. " \
                "SendGrid says #{result.parsed_response}")
  end
end
