ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('sinatra/activerecord')
require('department')
require('employee')
require('project')

RSpec.configure do |config|
  config.after(:each) do
    Department.all.each do |d|
      d.destroy
    end
  end
end
