class CreateStartups < ActiveRecord::Migration[8.0]
  def change
    create_table :startups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
