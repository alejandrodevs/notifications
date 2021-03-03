module Push
  class APNSService < BaseService

    private

    def message
      {
        default: notification[:body],
        APNS_SANDBOX: ios_message.to_json,
        APNS: ios_message.to_json
      }
    end

    def ios_message
      {
        aps: {
          title: notification[:title],
          alert: notification[:body],
        }.merge(notification[:data] || {})
      }
    end

    def app_sns_arn
      ENV['APPLE_APP_SNS_ARN']
    end
  end
end
