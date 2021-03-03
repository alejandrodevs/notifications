module Push
  class FCMService < BaseService

    private

    def message
      {
        default: notification[:body],
        GCM: android_message.to_json
      }
    end

    def android_message
      {
        data: {
          title: notification[:title],
          message: notification[:body]
        }.merge(notification[:data] || {})
      }
    end

    def app_sns_arn
      ENV['FCM_APP_SNS_ARN']
    end
  end
end
