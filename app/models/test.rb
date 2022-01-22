class Test < ApplicationRecord
  belongs_to :category

  def self.test_titles(category_title)
    joins(:category).where(categories: {title: category_title}).order(title: :desc).pluck(:title)
  end
end
