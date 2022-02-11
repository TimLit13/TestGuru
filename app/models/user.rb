require 'digest/sha1'

class User < ApplicationRecord

  include Auth

  
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test'
  
  validates :first_name, :last_name, :email, presence: true
  validates :password, presence: true, if: Proc.new{ |u| u.password_digest.blank? }
  validates :password, confirmation: true

  def tests_by_level(level)
    UserTest.where(user_id: id).joins(:test).where("tests.level = ?", level).pluck(:title)
  end

  def test_passage(test)
    test_passages.order(created_at: :desc).find_by(test_id: test.id)
  end

end
