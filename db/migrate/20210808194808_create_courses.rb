class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.boolean :self_assignable, default: true
      t.references :coach

      t.timestamps
    end
  end
end
