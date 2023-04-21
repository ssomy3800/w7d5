class CreateSubs < ActiveRecord::Migration[7.0]
  def change
    create_table :subs do |t|
      t.integer :user_id, null: false
      t.timestamps
    end

    add_foreign_key :subs, :users, column: :user_id
  end
end
