class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees, id: :uuid do |e|
      e.column :name, :varchar
      e.column :department_id, :uuid

      e.timestamps
    end
  end
end
