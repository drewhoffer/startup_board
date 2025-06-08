class ChangeLikesToUserBased < ActiveRecord::Migration[8.0]
  def change
    add_reference :likes, :user, null: false, foreign_key: true
    remove_column :likes, :ip_address, :string
    remove_index :likes, name: "index_likes_on_startup_id_and_ip_address"
    add_index :likes, [ :startup_id, :user_id ], unique: true
  end
end
