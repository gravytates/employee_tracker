require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './lib/department'
require './lib/employee'
require 'pry'

also_reload('lib/**/*.rb')

get '/' do
  @employees = Employee.all
  @departments = Department.all
  erb :index
end

post '/departments/new' do
  name = params.fetch 'department-name'
  department = Department.create({name: name})
  # id = department.id <---example of grabbing id
  @employees = Employee.all
  @departments = Department.all
  erb :index
end

get '/departments/:id' do
  @department = Department.find(params.fetch 'id')
  erb :department
end

patch '/department/update/:id' do
  department = Department.find(params.fetch 'id')
  name = params.fetch('department-name')
  department.update({name: name})
  @department = department
  erb :department
end

delete '/department/delete/:id' do
  department = Department.find(params.fetch 'id')
  department.delete
  @employees = Employee.all
  @departments = Department.all
  erb :index
end

post '/employee/new' do
  name = params.fetch 'employee-name'
  Employee.create({name: name})
  @employees = Employee.all
  @departments = Department.all
  erb :index
end

get '/employee/:id' do
  @employee = Employee.find(params.fetch 'id')
  @departments = Department.all
  erb :employee
end

patch '/employee/update/:id' do
  employee = Employee.find(params.fetch 'id')
  name = params.fetch('employee-name')
  employee.update({name: name})
  @employee = employee
  @departments = Department.all
  erb :employee
end

delete '/employee/delete/:id' do
  employee = Employee.find(params.fetch 'id')
  employee.delete
  @employees = Employee.all
  @departments = Department.all
  erb :index
end

patch '/employee/department/:id' do
  employee = Employee.find(params.fetch 'id')
  department = params.fetch 'department-id'
  employee.update({department_id: department})
  @employee = employee
  @department = employee.department.name
  @departments = Department.all
  erb :employee
end

get '/project_page' do
  erb :projects
end
