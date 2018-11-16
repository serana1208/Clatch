class AddColumnInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :Infos, :room_id, :integer
  end
end
