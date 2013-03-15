class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.text :title
      t.text :content
      t.integer :views_count
      t.integer :votes_count

      t.timestamps
    end
  end
end
