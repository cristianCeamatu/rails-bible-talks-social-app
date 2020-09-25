class CreateFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :followings do |t|
      t.integer :follower_id, null: false
      t.integer :followed_id, null: false

      t.timestamps
    end

    add_index :followings, :follower_id
    add_index :followings, :followed_id

    add_foreign_key :followings, :users, column: :follower_id
    add_foreign_key :followings, :users, column: :followed_id
  end
end
