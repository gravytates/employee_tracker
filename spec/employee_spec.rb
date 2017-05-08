require "spec_helper"

describe(Employee) do
  describe("#department") do
    it("tells which department it belongs to") do
      test_department = Department.create({:name => "CEO"})
      test_employee = Employee.create({:name => "Suzy", :department_id => test_department.id})
      expect(test_employee.department()).to(eq(test_department))
    end
  end
end
