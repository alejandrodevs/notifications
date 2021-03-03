require 'singleton'
require 'dotenv/load'
require 'aws-sdk-sns'

module SMS
  class Service
    include Singleton

    def initialize
      @sns = Aws::SNS::Client.new(
        region: ENV['AWS_REGION'],
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      )
    end

    def self.send(options = {})
      instance.publish(options)
    end

    def publish(options = {})
      @sns.publish(options)
    end
  end
end

SMS::Service.send(message: 'Example', phone_number: '+523310971195')
