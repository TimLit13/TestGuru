class Badge < ApplicationRecord
  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements
end
