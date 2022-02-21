class CreateGists < ActiveRecord::Migration[6.1]
  def change
    create_table :gists do |t|
      t.references :author, null: false, foreign_key: {to_table: :users}
      t.references :question, null: false, foreign_key: true
      t.string :url, null: false

      t.timestamps
    end
  end
end
