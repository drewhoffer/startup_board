class AddUserToStartups < ActiveRecord::Migration[8.0]
  def change
    add_reference :startups, :user, null: false, foreign_key: true
  end
end
