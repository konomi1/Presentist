class ChangeColumnToNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :introduce, :text, null: true
    change_column :users, :image_id, :string, null: true
    change_column :presents, :memo, :text, null: true
    change_column :presents, :price, :integer, null: true
    change_column :friends, :memo, :text, null: true
    change_column :events, :memo, :text, null: true
  end
  
  def down
    change_column :users, :introduce, :text, null: false
    change_column :users, :image_id, :string, null: false
    change_column :presents, :memo, :text, null: false
    change_column :presents, :price, :integer, null: false
    change_column :friends, :memo, :text, null: false
    change_column :events, :memo, :text, null: false
  end
end
