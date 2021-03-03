require 'singleton'
require 'dotenv/load'
require 'aws-sdk-sns'
require './push/base_service'
require './push/apns_service'
require './push/fcm_service'

module Push
  class Service
    SERVICES = {
      ios: APNSService,
      android: FCMService
    }

    def self.send(options = {})
      device_os = options.fetch(:device_os).to_sym
      SERVICES[device_os].send(options)
    end
  end
end

notification = { title: 'New notification', body: "Here's some information for you!" }
Push::Service.send(device_os: :ios, device_token: 'XXXXX', notification: notification)
