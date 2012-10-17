require 'rubygems'
require 'torquespec'
require 'capybara'
require 'capybara/dsl'

TorqueSpec.configure do |config|
  config.drb_port = 7772
  config.knob_root = ".torquespec"
  config.lazy = true
end

Capybara.default_driver = :selenium
Capybara.app_host = "http://localhost:8080/cas/"
Capybara.run_server = false

RSpec.configure do |config|
  config.include Capybara::DSL
  config.after do
    Capybara.reset_sessions!
  end
end

