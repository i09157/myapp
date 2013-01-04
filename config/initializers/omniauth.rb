Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['MYAPP_CONSUMER_ID'], ENV['MYAPP_CONSUMER_SECRET']
end