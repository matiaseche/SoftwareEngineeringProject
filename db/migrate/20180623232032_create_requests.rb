class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.integer :forum_thread_id
      t.string :state, default: "Pendiente"
    end
  end
end
