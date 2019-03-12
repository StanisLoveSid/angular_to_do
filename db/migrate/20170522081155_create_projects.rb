class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title, default: 'New TODO List'
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
