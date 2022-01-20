class AddAnswersColumnCorrect < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :correct, :boolean, default: false, null: false
  end
end