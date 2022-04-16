class ChangeCloumnsNotnullAddReports < ActiveRecord::Migration[6.1]
  def change
    change_column :reports, :title, :string, null: false
    change_column :reports, :content, :text, null: false
    change_column :reports, :user_id, :integer, null: false
  end
end
