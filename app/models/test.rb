class Test < ApplicationRecord
  has_many :questions
  has_many :test_passages
  has_many :users, through: :test_passages
  belongs_to :author, foreign_key: :author_id, class_name: 'User'
  belongs_to :category

  validates :title, presence: true, uniqueness: { scope: :level }
  validates :level, numericality: {
    only_integer: true, 
    greater_than: 0
  }

  scope :easy_tests, -> { where(level: 0..1) }
  scope :average_tests, -> { where(level: 2..4) }
  scope :difficult_tests, -> { where(level: 5..Float::INFINITY) }
  scope :tests_by_category, -> (category_title) { joins(:category).where(categories: {title: category_title}) }

  def self.test_titles(category_title)
    tests_by_category(category_title).order(title: :desc).pluck(:title)
  end
end
