require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './lib/department'
require './lib/employee'
require 'pry'

also_reload('lib/**/*.rb')

get '/' do
  @departments = Department.all
  erb :index
end

post '/departments/new' do
  name = params.fetch 'name'
  department = Department.create({:name => name})
  # id = department.id <---example of grabbing id
  @departments = Department.all
  erb :index
end

get '/departments/:id' do
  @department = Department.find(params.fetch 'id')
  erb :department
end

delete '/department/delete/:id' do
  department = Department.find(params.fetch 'id')
  department.delete
  @departments = Department.all
  erb :index
end
