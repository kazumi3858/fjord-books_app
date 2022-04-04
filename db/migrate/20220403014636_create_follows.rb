class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :following_user_id
      t.integer :follower_user_id

      t.timestamps
    end
    add_index :follows, :following_user_id
    add_index :follows, :follower_user_id
    add_index :follows, [:following_user_id, :follower_user_id], unique: true
  end
end
