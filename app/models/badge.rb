class Badge < ApplicationRecord

  RULES = %w[completed_first_try completed_category completed_level]

  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
end
