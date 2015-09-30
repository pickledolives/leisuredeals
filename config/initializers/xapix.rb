XapixClient.configure do |config|
  config.project_name = ENV['XAPIX_PROJECT_NAME']
  config.auth_token = ENV['XAPIX_AUTH_TOKEN']
end



# THIS IS FOR XAPIX.IO PLATFORM DEVS ONLY!!! TO TEST PLATFORM VS LEISUREDEALS BOTH LOCALLY
XAPIX_HOST = Rails.env == 'development' && ENV['XAPIX_SERVER'] == 'local' ? 'http://localhost:3000' : 'https://app.xapix.io'
puts "XAPIX host is '#{XAPIX_HOST}'"

module XapixClient
  class Connection < JsonApiClient::Connection
    def initialize(options = {})
      fail(XapixClient::NoConfigurationError) if XapixClient.configuration.nil?
      fail(XapixClient::BadConfigurationError) if XapixClient.configuration.project_name.nil?
      super(options.merge(site: "#{XAPIX_HOST}/api/v1/#{XapixClient.configuration.project_name}/"))
    end
  end
end 
