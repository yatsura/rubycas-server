TorqueBox.configure do
  web do |web|
    web.context "/cas"
  end
  ruby do
    version "1.9"
  end
  environment do
    CONFIG_FILE '/home/pmitche2/development/ruby/sinatra/rubycas-server/development/config/config.development.yml'
  end
end

