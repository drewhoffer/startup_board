class AddSocialLinksToStartup < ActiveRecord::Migration[8.0]
  def change
    add_column :startups, :discord_url, :string
    add_column :startups, :github_url, :string
    add_column :startups, :linkedin_url, :string
    add_column :startups, :twitter_url, :string
    add_column :startups, :instagram_url, :string
  end
end
