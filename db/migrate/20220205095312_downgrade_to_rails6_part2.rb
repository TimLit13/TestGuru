class DowngradeToRails6Part2 < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tests, :title, false
    change_column_null :tests, :level, false

    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :email, false

    change_column_null :categories, :title, false

    change_column_null :answers, :body, false
    change_column_null :questions, :body, false

    add_column :answers, :correct, :boolean, default: false, null: false

    change_column_default :tests, :level, 1
  end
end
