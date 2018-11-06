class AddColumnCalender < ActiveRecord::Migration[5.1]
  def change
    add_column :calendars, :filename, :string
  end
end
