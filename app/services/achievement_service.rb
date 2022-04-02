class AchievementService

  def initialize(test_passage)
    @test_passage = test_passage
    @test = test_passage.test
    @user = test_passage.user
    @rules = Badge::RULES
  end

  def reward_achievement
    counter = 0

    if success_test_first_try?
      Achievement.create(user: @user, badge: Badge.find_by(rule: @rules[0]))
      counter += 1
      puts "=" * 80
      puts counter
      puts "=" * 80
    end  

    if success_all_tests_category?
      Achievement.create(user: @user, badge: Badge.find_by(rule: @rules[1]))
      counter += 1
    end

    if success_level_complete?
      Achievement.create(user: @user, badge: Badge.find_by(rule: @rules[2]))
      counter += 1 
    end

    counter > 0
  end

  private

  def success_test_first_try?
    @test_passage.test_passage_success? && (@user.test_passages.count{ |test_passage| test_passage.test_id ==  @test.id } <= 1)
  end

  def success_all_tests_category?
    test_ids = Category.find(@test.category_id).tests.pluck(:id)

    test_ids.count == user_successfylly_completed_test_passages(test_ids)
  end

  def success_level_complete?
    test_ids = Test.where(level: @test.level).pluck(:id)

    test_ids.count == user_successfylly_completed_test_passages(test_ids)
  end

  def user_successfylly_completed_test_passages(test_ids)
    @user.test_passages
         .where(test_id: test_ids)
         .select{ |test_passage| test_passage.completed? && test_passage.test_passage_success? }
         .pluck(:test_id)
         .uniq
         .count
  end

end
