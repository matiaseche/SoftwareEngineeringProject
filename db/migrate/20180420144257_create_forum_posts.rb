class CreateForumPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_posts do |t|
      t.integer :forum_thread_id
      t.integer :user_id
      t.text :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
