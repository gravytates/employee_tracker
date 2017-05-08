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
  redirect "/departments/#{department.id}"
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
  @projects = Project.all
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
  redirect "/employee/#{@employee.id}"
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
  erb :project_details
end

patch '/project/update/:id' do
  project = Project.find(params.fetch 'id')
  name = params.fetch('project-name')
  project.update({name: name})
  redirect "/project/#{project.id}"
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
  redirect "/project/#{project_id}"
end

patch '/employee/project/:id' do
  @employee = Employee.find(params.fetch 'id')
  project_id = params.fetch 'project-id'
  @employee.update({project_id: project_id})
  redirect "/employee/#{@employee.id}"
end
