OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TUMIMO_TWITTER_KEY'], ENV['TUMIMO_TWITTER_SECRET']
end