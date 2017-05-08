require "capybara/rspec"
require "./app"

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a department', {:type => :feature}) do
  it('allows a user to add a department to the website') do
    visit('/')

    fill_in('department-name', :with =>'HR')

    click_button('add department')
    expect(page).to have_content('Employee Tracker')
  end
end

describe('adding an employee', {:type => :feature}) do
  it('allows a user to add an employee to the website') do
    visit('/')

    fill_in('employee-name', :with =>'Fred')

    click_button('add employee')
    expect(page).to have_content('Employee Tracker')
  end
end

describe('delete department', {:type => :feature}) do
  it('allows a user to delete department from the website') do
    department = Department.create({name: "HR"})
    visit("/departments/#{department.id}")

    click_button('delete department')
    expect(page).to have_content('Employee Tracker')
  end
end

describe('update department', {:type => :feature}) do
  it('allows a user to update department name') do
    department = Department.create({name: "HR"})
    visit("/departments/#{department.id}")

    fill_in('department-name', :with => 'Human Resources')
    click_button('update department')
    expect(page).to have_content('Human Resources')
  end
end

describe('update department', {:type => :feature}) do
  it('allows a user to update department name') do
    department = Department.create({name: "HR"})
    visit("/departments/#{department.id}")

    fill_in('department-name', :with => 'Human Resources')
    click_button('update department')
    expect(page).to have_content('Human Resources')
  end
end
