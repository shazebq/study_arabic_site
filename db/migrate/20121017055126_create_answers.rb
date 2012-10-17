class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :forum_post_id
      t.integer :user_id

      t.timestamps
    end
  end
end
