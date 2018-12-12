class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :sposts do |t|
     t.string :title
      t.string :content
      t.integer :user_id
    end
  end
end
