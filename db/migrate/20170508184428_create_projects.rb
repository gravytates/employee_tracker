class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |p|
      p.column :name, :varchar

      p.timestamps
    end
    add_column :employees, :project_id, :uuid
  end
end
