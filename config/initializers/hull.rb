Hull.configure do |config|
  config.app_id     = ENV['HULL_APP_ID']
  config.app_secret = ENV['HULL_APP_SECRET']
  config.org_url    = ENV['HULL_ORG_URL']
end