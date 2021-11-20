class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id,       null: false
      t.integer :friend_id,     null: false
      t.date    :date,          null: false
      t.integer :scene_status,  null: false, defalt: 0
      t.text    :memo,          null: false
      t.integer :ready_status,  null: false, defalt: 0

      t.timestamps
    end
    add_index :events, :user_id
    add_index :events, :friend_id
  end
end
