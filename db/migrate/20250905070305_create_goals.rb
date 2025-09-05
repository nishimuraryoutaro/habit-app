class CreateGoals < ActiveRecord::Migration[8.0]
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.date :target_date
      t.integer :progress
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
