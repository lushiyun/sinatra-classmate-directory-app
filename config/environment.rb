ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
Dotenv.load if ENV['SINATRA_ENV'] == 'development'

# set :environment, ENV['SINATRA_ENV'].to_sym

# database_config = {
#   :development => {
#     :adapter => 'sqlite3',
#     :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
#   }
# }

set :database_file, "./database.yml"

# set :database, database_config

require 'rack-flash'

require_relative '../app/controllers/application_controller.rb'
require_all 'app'