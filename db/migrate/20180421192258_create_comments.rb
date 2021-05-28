class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id
      t.integer :forum_post_id

      t.timestamps
    end
  end
end
