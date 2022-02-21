class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy
  belongs_to :test

  validates :body, presence: true
end
