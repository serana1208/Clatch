class AddColumnTalks < ActiveRecord::Migration[5.1]
  def change

    add_column :talks,:croom_id,:integer

  end
end
