class CreateDailyTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goal, null: false, foreign_key: true
      t.string :title, null: false
      t.date :date, null: false
      t.boolean :done, default: false, null: false
      t.integer :priority, default: 0, null: false
      t.timestamps
    end
    add_index :daily_tasks, [ :user_id, :goal_id, :date ]
  end
end
