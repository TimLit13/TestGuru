class User < ApplicationRecord

  def tests_by_level(level)
    UserTest.where(user_id: id).joins(:test).where("tests.level = ?", level).pluck(:title)
  end
end
