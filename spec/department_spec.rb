require "spec_helper"

describe(Department) do
  describe("#employees") do
    it("tells which employees are assigned to it") do
      test_department = Department.create({:name => "HR"})
      test_employee1 = Employee.create({:name => "Fred", :department_id => test_department.id})
      test_employee2 = Employee.create({:name => "Karen", :department_id => test_department.id})
     expect(test_department.employees()).to(eq([test_employee1, test_employee2]))
    end
  end
end
