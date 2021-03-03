module Push
  class BaseService
    attr_reader :device_os,
                :device_token,
                :notification

    def initialize(options = {})
      @device_os    = options.fetch(:device_os)
      @device_token = options.fetch(:device_token)
      @notification = options.fetch(:notification)

      @sns = Aws::SNS::Client.new(
        region: ENV['AWS_REGION'],
        access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
      )
    end

    def self.send(options = {})
      new(options).publish
    end

    def publish
      # Creates user's token endpoint.
      res = @sns.create_platform_endpoint(
        platform_application_arn: app_sns_arn,
        token: device_token
      )

      # Publishes SNS message.
      @sns.publish(
        target_arn: res.endpoint_arn,
        message: message.to_json,
        message_structure: :json
      )
    end

    private

    def message
      raise NotImplementedError
    end

    def app_sns_arn
      raise NotImplementedError
    end
  end
end
