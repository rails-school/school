class LessonTweeter
  include UsersHelper

  def initialize(lesson, teacher)
    @lesson = lesson
    @teacher = teacher
  end

  def tweet
    status = lesson.tweet_message.present? ? lesson.tweet_message : default_content
    if status.match(/{{URL}}/i)
      status.gsub!(/{{URL}}/i, url)
    else
      status += " - #{url}"
    end
    begin
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token = ENV['TWITTER_OAUTH_TOKEN']
        config.access_token_secret = ENV['TWITTER_OAUTH_SECRET']
      end
      client.update(status)
      true
    rescue StandardError
      false
    end
  end

private
  attr_reader :lesson, :teacher

  def default_content
    <<-TWEET.strip_heredoc.sub(/\n$/, "")
    Shame on #{first_name(teacher) } for this boring message. The next class is "#{lesson.title}"! {{URL}}
    TWEET
  end

  def url
    Rails.application.routes.url_helpers.lesson_url(lesson)
  end
end
