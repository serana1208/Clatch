class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :content
      t.datetime :eventday

      t.timestamps
    end
  end
end
