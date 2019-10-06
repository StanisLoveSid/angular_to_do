class AddAttachmentsToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :attachment, :string
  end
end
