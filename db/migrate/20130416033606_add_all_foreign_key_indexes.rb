class AddAllForeignKeyIndexes < ActiveRecord::Migration
  def up
    add_index :answers, :user_id
    add_index :answers, :forum_post_id
    
    add_index :articles, :user_id

    add_index :votes, :user_id
    add_index :votes, [:voteable_id, :voteable_type] 

    add_index :views, [:viewable_id, :viewable_type] 

    add_index :categories_categorizables, [:categorizable_id, :categorizable_type], name: "catgories_join_index1" # for the polymorphic part
    add_index :categories_categorizables, [:category_id, :categorizable_id], name: "categories_join_index2" # for the has_many part

    add_index :categories, :category_parent_id 

    add_index :centers, :address_id
    add_index :centers, :user_id
    
    add_index :cities, :country_id

    add_index :forum_posts, :user_id

    add_index :images, :user_id

    add_index :resources, :user_id
    add_index :resources, :level_id

    add_index :reviews, :user_id
    add_index :reviews, [:reviewable_id, :reviewable_type]

    add_index :student_profiles, :level_id

    add_index :teacher_profiles, :degree_id
    add_index :teacher_profiles, :city_id

    add_index :teachers_languages, [:teacher_profile_id, :language_id]

    add_index :users, [:profile_id, :profile_type] 
    add_index :users, :country_id
  end

  def down
    remove_index :anwers, :user_id
    remove_index :anwers, :forum_post_id

    remove_index :articles, :user_id
    
    remove_index :votes, [:voteable_id, :voteable_type] 

    remove_index :votes, :user_id
    remove_index :views, [:viewable_id, :viewable_type] 

    remove_index :categories_categorizables, [:categorizable_id, :categorizable_type] # for the polymorphic part
    remove_index :categories_categorizables, [:category_id, :categorizable_id] # for the has_many part

    remove_index :categories, :category_parent_id 

    remove_index :centers, :address_id
    remove_index :centers, :user_id

    remove_index :cities, :country_id

    remove_index :forum_posts, :user_id

    remove_index :images, :user_id

    remove_index :resources, :user_id
    remove_index :resources, :level_id

    remove_index :reviews, :user_id
    remove_index :reviews, [:reviewable_id, :reviewable_type]

    remove_index :student_profiles, :level_id

    remove_index :teacher_profiles, :degree_id
    remove_index :teacher_profiles, :city_id

    remove_index :teachers_languages, [:teacher_profile_id, :language_id]

    remove_index :users, [:profile_id, :profile_type] 
    remove_index :users, :country_id
  end
end
