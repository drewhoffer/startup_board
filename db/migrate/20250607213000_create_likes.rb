class CreateLikes < ActiveRecord::Migration[8.0]
  def change
    create_table :likes do |t|
      t.references :startup, null: false, foreign_key: true
      t.string :ip_address, null: false
      t.timestamps
    end
    add_index :likes, [ :startup_id, :ip_address ], unique: true
  end
end
