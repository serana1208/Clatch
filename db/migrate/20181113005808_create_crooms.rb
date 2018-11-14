class CreateCrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :crooms do |t|
      t.integer :grade
      t.integer :room
      t.string :name

      t.timestamps
    end
  end
end
