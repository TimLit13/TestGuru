class AddReadyToTest < ActiveRecord::Migration[6.1]
  def change
     add_column :tests, :ready, :boolean, null: false, default: false
  end
end
