class Badge < ApplicationRecord

  RULES = %w[first_rule second_rule third_rule]

  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements
end
