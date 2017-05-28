ENV['RAILS_ENV'] = 'test'
require 'coveralls'
Coveralls.wear!

require 'rubygems'
require 'rspec'
require 'uniqueness'
require 'uniqueness/generator'

Bundler.require(:default)
# Connect to database
ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                        database: ':memory:')
# Load our schema
# ActiveRecord::Base.logger = Logger.new(STDOUT)
load(File.join(File.dirname(__FILE__), 'schema.rb'))

# Define the testing model
class Page < ActiveRecord::Base
  has_unique_field :uid
  has_unique_field :short_code, length: 9, type: :human
  has_unique_field :token, length: 12, type: :url
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run focus: true
end
