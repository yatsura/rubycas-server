require 'rubygems'
require 'sinatra'
require 'rspec'
require 'logger'
require 'ostruct'
require 'capybara'
require 'capybara/dsl'
require 'cgi'

# TB PDM
require 'torquespec'
#

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

# TB PDM
TorqueSpec.local {
  Capybara.run_server = false
  Capybara.default_driver = :selenium
  Capybara.app_host = "http://localhost:8080/cas"

  RSpec.configure do |config|
    config.include Capybara::DSL
    config.include TorqueBox::Injectors

    config.after do
      Capybara.reset_sessions!
    end
  end
}

#

if Dir.getwd =~ /\/spec$/
  # Avoid potential weirdness by changing the working directory to the CASServer root
  FileUtils.cd('..')
end

def silence_warnings
  old_verbose, $VERBOSE = $VERBOSE, nil
  yield
ensure
  $VERBOSE = old_verbose
end

# This called in specs' `before` block.
# Due to the way Sinatra applications are loaded,
# we're forced to delay loading of the server code
# until the start of each test so that certain 
# configuraiton options can be changed (e.g. `uri_path`)
def load_server(config_file)
  # Now happens in torquebox.rb within the config dir
end

# Deletes the sqlite3 database specified in the app's config
# and runs the db:migrate rake tasks to rebuild the database schema.
def reset_spec_database
  # This should be moved to database_cleaner
end

def config_file_name(type="default")
  File.dirname(__FILE__) + "/#{type}_config" + (defined?(JRUBY_VERSION) == "constant" ? "_java.yml" : ".yml")
end
