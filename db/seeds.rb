# clear db before seed
UserTest.delete_all if UserTest.any?
User.delete_all if User.any?
Answer.delete_all if Answer.any?
Question.delete_all if Question.any?
Test.delete_all if Test.any?
Category.delete_all if Category.any?

# seed categories
categories = []
3.times do
  category_title = Faker::ProgrammingLanguage.name
  categories.push(Category.create(title: category_title))
end

# seed tests
tests = []
10.times do
  test_title = Faker::Lorem.sentence(word_count: 4)
  test_level = rand(1..5)
  test_category_id = categories.map(&:id).sample
  tests.push(Test.create(title: test_title, level: test_level, category_id: test_category_id))
end

# seed questions
questions = []
30.times do
  question_body = Faker::Lorem.question
  question_test_id = tests.map(&:id).sample
  questions.push(Question.create(body: question_body, test_id: question_test_id))
end

# seed answers
answers = []
30.times do
  answer_body = Faker::Lorem.paragraph(sentence_count: 2)
  answer_question_id = questions.map(&:id).sample
  answer_correct = [true, false].sample
  Answer.create(body: answer_body, question_id: answer_question_id, correct: answer_correct)
end

# seed users
users = []
1.upto(5) do |i|
  user_name = Faker::Sports::Football.player
  user_first_name = user_name.split(' ').first
  user_last_name = user_name.split(' ').last
  user_email = Faker::Internet.email
  user_admin = if i == 1
                 true
               else
                 false
               end
  User.create(first_name: user_first_name, last_name: user_last_name, email: user_email, admin: user_admin)
end

# make references between users and tests
Test.count.times do |n| 
  user_test_user = users.map(&:id).sample
  user_test_test = tests.map(&:id).sample
  UserTest.create(user_id: user_test_user, test_id: user_test_test)
end
