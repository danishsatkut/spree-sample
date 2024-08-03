Bugsnag.configure do |config|
  config.api_key = Rails.application.credentials.bugsnag&.api_key

  config.enabled_release_stages = ['production']
end
