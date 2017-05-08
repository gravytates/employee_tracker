require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './lib/department'
require './lib/employee'
require './lib/project'
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
  redirect '/'
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
  redirect '/'
end

post '/employee/new' do
  name = params.fetch 'employee-name'
  Employee.create({name: name})
  redirect '/'
end

get '/employee/:id' do
  @employee = Employee.find(params.fetch 'id')
  @department = @employee.department ? @employee.department.name : "none"
  @departments = Department.all
  @project = @employee.project ? @employee.project.name : "none"
  # @projects = Project.all
  erb :employee
end

patch '/employee/update/:id' do
  employee = Employee.find(params.fetch 'id')
  name = params.fetch('employee-name')
  employee.update({name: name})
  redirect "/employee/#{employee.id}"
end

delete '/employee/delete/:id' do
  employee = Employee.find(params.fetch 'id')
  employee.delete
  redirect '/'
end

patch '/employee/department/:id' do
  @employee = Employee.find(params.fetch 'id')
  department = params.fetch 'department-id'
  @employee.update({department_id: department})
  # @project = @employee.project.name
  # @projects = Project.all
  @departments = Department.all
  @department = @employee.department ? @employee.department.name : "none"
  @project = @employee.project ? @employee.project.name : "none"
  erb :employee
end

get '/project_page' do
  @projects = Project.all
  erb :projects
end

post '/project/new' do
  name = params.fetch 'project-name'
  Project.create({name: name})
  redirect '/project_page'
end

get '/project/:id' do
  @project = Project.find(params.fetch 'id')
  @employees = Employee.all
  # @employee = Employee.
  erb :project_details
end

patch '/project/update/:id' do
  project = Project.find(params.fetch 'id')
  name = params.fetch('project-name')
  project.update({name: name})
  @project = project
  @employees = Employee.all

  erb :project_details
end

delete '/project/delete/:id' do
  project = Project.find(params.fetch 'id')
  project.delete
  redirect '/project_page'
end

patch '/project/:id/add_employees' do
  project_id = params.fetch 'id'
  selected_employee_ids = params.fetch 'employee_ids'
  selected_employee_ids.each do |e|
    Employee.find(e).update({project_id: project_id})
  end
  # @project_employees

  @project = Project.find(params.fetch 'id')
  @employees = Employee.all
  erb :project_details
end

# patch '/employee/project/:id' do
#   @employee = Employee.find(params.fetch 'id')
#   project = params.fetch 'project-id'
#   @employee.update({project_id: project})
#   @project = @employee.project.name
#   @projects = Project.all
#   @departments = Department.all
#   @department = @employee.department.name
#
#   erb :employee
# end
