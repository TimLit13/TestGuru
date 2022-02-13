class User < ApplicationRecord

  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable,
         :trackable, 
         :validatable,
         :confirmable
  
  EMAIL_FORMAT = URI::MailTo::EMAIL_REGEXP

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :author_tests, foreign_key: :author_id, class_name: 'Test'
  
  validates :first_name, :last_name, presence: true
  validates :email, presence: true,
                    format: { with: EMAIL_FORMAT, message: "не является email"},
                    uniqueness: true

  def tests_by_level(level)
    UserTest.where(user_id: id).joins(:test).where("tests.level = ?", level).pluck(:title)
  end

  def test_passage(test)
    test_passages.order(created_at: :desc).find_by(test_id: test.id)
  end
end
