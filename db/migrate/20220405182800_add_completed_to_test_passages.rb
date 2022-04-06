class AddCompletedToTestPassages < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :completed, :boolean, default: false, null: false
  end
end
