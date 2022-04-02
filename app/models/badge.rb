class Badge < ApplicationRecord

  RULES = ["First try success", "Successfully passed all tests in category", "Successfully passed all tests in level"]

  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements
end
