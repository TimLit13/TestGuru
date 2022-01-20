class AddTestsLevelDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :tests, :level, 1
  end
end
