class AddColumnTimetable < ActiveRecord::Migration[5.1]
  def change
    add_column :timetables, :filename, :string
  end
end
