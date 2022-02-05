class DowngradeToRails6 < ActiveRecord::Migration[6.1]
  def change
    create_table :tests do |t|
      t.string :title
      t.integer :level
      t.references :category, foreign_key: true

      t.timestamps
    end

    create_table :questions do |t|
      t.text :body
      t.references :test, foreign_key: true

      t.timestamps
    end

    create_table :answers do |t|
      t.text :body
      t.references :question, foreign_key: true

      t.timestamps
    end

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :admin

      t.timestamps
    end

    create_table :categories do |t|
      t.string :title

      t.timestamps
    end
  end
end
