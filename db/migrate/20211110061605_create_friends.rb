class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|

      t.integer   :user_id,     null: false, default: ""
      t.string    :name,        null: false, default: ""
      t.string    :kana_name,   null: false, default: ""
      t.integer   :relation,    null: false, default: 0
      t.integer   :gender,      null: false, default: 0
      t.text      :memo,        null: false
      t.timestamps
    end

    add_index :friends, :user_id
  end
end
