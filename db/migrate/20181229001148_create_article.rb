class CreateArticle < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.belongs_to :user, profile: true
      t.string :title
      t.string :content
      t.integer :user_id
    end
  end
end
