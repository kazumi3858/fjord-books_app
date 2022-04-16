class ChangeCloumnsNotnullAddComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :comment, :text, null: false
    change_column :comments, :commentable_type, :string, null: false
    change_column :comments, :commentable_id, :integer, null: false
  end
end
