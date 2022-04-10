class AchievementService

  def initialize(test_passage)
    @test_passage = test_passage
    @test = test_passage.test
    @user = test_passage.user
    @badges = []
  end

  def call
    Badge.where.not(option: 0).select do |badge| 
      @badges.push(badge) if send(badge.rule, badge.option) 
    end
      @user.badges.push(@badges) if @badges.any?
      @badges.any?
  end

  private

  def completed_first_try(_option)
    @test_passage.completed && (TestPassage.where(user: @user, test: @test).count <= 1)
  end

  def completed_category(category_level)
    test_ids = Test.tests_by_category(category_level).pluck(:id)

    test_ids.count == user_successfylly_completed_test_passages(test_ids)
  end

  def completed_level(test_level)
    test_ids = Test.where(level: test_level).pluck(:id)

    test_ids.count == user_successfylly_completed_test_passages(test_ids)
  end

  def user_successfylly_completed_test_passages(test_ids)
    TestPassage.where(user: @user, test_id: test_ids, completed: true)
               .pluck(:test_id)
               .uniq
               .count
  end
end
