require 'digest/sha1'

class User < ApplicationRecord
  
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test'
  
  has_secure_password

  def tests_by_level(level)
    UserTest.where(user_id: id).joins(:test).where("tests.level = ?", level).pluck(:title)
  end

  def test_passage(test)
    test_passages.order(created_at: :desc).find_by(test_id: test.id)
  end

end
