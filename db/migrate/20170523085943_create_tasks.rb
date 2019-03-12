class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :project, foreign_key: true
      t.boolean :done, default: false
      t.date :deadline
      t.string :title
      t.integer :position

      t.timestamps
    end
  end
end
