class CreatePolls < ActiveRecord::Migration[5.1]
  def change
    create_table :polls do |t|
      t.string :question
      t.integer :user_id
      t.integer :forum_thread_id

      t.timestamps
    end
  end
end
