class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :content
      t.integer :votes, default: 0
      t.integer :poll_id

      t.timestamps
    end
  end
end
