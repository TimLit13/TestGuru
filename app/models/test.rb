class Test < ApplicationRecord
  has_many :questions
  has_many :user_tests
  has_many :users, through: :user_tests 
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :category

  scope :easy_tests, -> { where(level: 0..1) }
  scope :average_tests, -> { where(level: 2..4) }
  scope :difficult_tests, -> { where(level: 5..Float::INFINITY) }

  scope :test_titles, -> (category_title) { joins(:category).where(categories: {title: category_title.strip.capitalize}).order(title: :desc).pluck(:title)
 }
end
