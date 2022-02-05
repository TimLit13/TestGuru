class DowngradeToRails6Part3 < ActiveRecord::Migration[6.1]
  def change
    create_table :user_tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :tests, :author, foreign_key: { to_table: :users }
    
    add_index :tests, [:title, :level], unique: true
  end
end
