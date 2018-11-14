class Createclassroom < ActiveRecord::Migration[5.1]
  def change
    create_table :Classrooms do |t|
      t.integer :grade
      t.integer :room
      t.string :name

      t.timestamps
    end
  end
end
