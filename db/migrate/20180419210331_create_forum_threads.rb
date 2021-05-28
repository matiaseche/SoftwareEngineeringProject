class CreateForumThreads < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_threads do |t|
      t.integer :user_id
      t.text :subject, null: false

      t.timestamps
    end
  end
end
