require "houston"

class IOSNotificationSender
  include Sidekiq::Worker

  def perform(device_token, lesson)
    notification = Houston::Notification.new(device: device_token["token"])
    notification.alert = lesson["title"]
    notification.sound = "true"
    notification.badge = 1
    IOS_APN.push notification
  end
end
