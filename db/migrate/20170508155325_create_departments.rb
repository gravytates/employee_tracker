ActiveRecord::Base.connection.execute('create extension if not exists "pgcrypto"')

class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments, id: :uuid do |d|
      d.column(:name, :varchar)

      d.timestamps
    end
  end
end
