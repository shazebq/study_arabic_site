class AddThumbnailUrlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :thumbnail_url, :string
  end
end
