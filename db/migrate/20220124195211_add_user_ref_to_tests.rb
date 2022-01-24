class AddUserRefToTests < ActiveRecord::Migration[7.0]
  def change
    add_reference :tests, :user, foreign_key: true
    rename_column :tests, :user_id, :author_id
  end
end
