class User < ApplicationRecord
  has_many :user_tests
  has_many :tests, through: :user_tests
  has_many :tests, foreign_key: :author_id, class_name: 'Test'
  def tests_by_level(level)
    UserTest.where(user_id: id).joins(:test).where("tests.level = ?", level).pluck(:title)
  end
end
