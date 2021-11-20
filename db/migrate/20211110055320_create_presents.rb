class CreatePresents < ActiveRecord::Migration[5.2]
  def change
    create_table :presents do |t|
      t.integer   :user_id,         null: false, default: ""
      t.integer   :friend_id,       null: false, default: ""
      t.integer   :gift_status,     null: false, default: 0
      t.integer   :age,             null: false, default: ""
      t.string    :item,            null: false, default: ""
      t.integer   :price,           null: false, default: ""
      t.string    :item_image_id
      t.integer   :scene_status,    null: false, default: 0
      t.integer   :return_status,   null: false, default: 0
      t.text      :memo,            null: false
      t.timestamps
    end
    add_index :presents, :user_id
    add_index :presents, :friend_id
  end
end
