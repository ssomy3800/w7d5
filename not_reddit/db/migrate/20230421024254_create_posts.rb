class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :content
      t.integer :sub_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end

    add_foreign_key :posts, :subs, column: :sub_id
    add_foreign_key :posts, :users, column: :user_id
    add_index :posts, :title
  end
end
