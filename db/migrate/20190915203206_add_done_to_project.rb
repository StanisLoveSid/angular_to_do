class AddDoneToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :done, :boolean, default: false
  end
end
