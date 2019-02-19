class AddColumnInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :infos, :room_id, :integer
  end
end
