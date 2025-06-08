class AddUrlToStartup < ActiveRecord::Migration[8.0]
  def change
    add_column :startups, :url, :string
  end
end
