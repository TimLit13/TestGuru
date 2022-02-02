class Category < ApplicationRecord
  has_many :tests

  validates :body, presence: true

  default_scope { order(title: :asc) }
end
