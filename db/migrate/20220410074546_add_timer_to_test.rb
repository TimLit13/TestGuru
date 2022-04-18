class AddTimerToTest < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :timer, :integer
  end
end
