class Test < ApplicationRecord
  has_many :questions
  has_many :user_tests
  has_many :users, through: :user_tests 
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :category

  def self.test_titles(category_title)
    joins(:category).where(categories: {title: category_title}).order(title: :desc).pluck(:title)
  end
end
