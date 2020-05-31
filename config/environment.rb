ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

set :environment, ENV['SINATRA_ENV'].to_sym

database_config = {
  :development => {
    :adapter => 'sqlite3',
    :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
  }
}

# ActiveRecord::Base.establish_connection(development_database_config)
set :database, database_config

require 'rack-flash'

require_relative '../app/controllers/application_controller.rb'
require_all 'app'
