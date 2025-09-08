class CreateSubGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :sub_goals do |t|
      t.references :goal, null: false, foreign_key: true
      t.string :title, null: false
      t.date :due_on
      t.integer :progress, default: 0, null: false
      t.timestamps
    end
    add_index :sub_goals, :due_on
  end
end
