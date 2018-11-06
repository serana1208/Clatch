class CreateInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :infos do |t|
      t.string :title
      t.string :content
      t.date :limit
      t.string :filename

      t.timestamps
      

    end
  end
end
