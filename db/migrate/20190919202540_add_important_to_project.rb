class AddImportantToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :important, :boolean
  end
end
