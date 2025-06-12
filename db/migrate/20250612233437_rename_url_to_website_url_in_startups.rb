class RenameUrlToWebsiteUrlInStartups < ActiveRecord::Migration[8.0]
  def change
    rename_column :startups, :url, :website_url
  end
end
