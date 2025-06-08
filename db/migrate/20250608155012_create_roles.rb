class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.references :startup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
