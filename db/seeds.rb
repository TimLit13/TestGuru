CATEGORIES_SEED = 2
TESTS_SEED = 5
QUESTIONS_SEED = 10
ANSWERS_SEED = 10
USERS_SEED = 3

# clear db before seed
UserTest.delete_all if UserTest.any?
Answer.delete_all if Answer.any?
Question.delete_all if Question.any?
Test.delete_all if Test.any?
User.delete_all if User.any?
Category.delete_all if Category.any?

# seed categories
categories = []
CATEGORIES_SEED.times do
  category_title = Faker::ProgrammingLanguage.name
  categories.push(Category.create(title: category_title))
end

# seed users
users = []
1.upto(USERS_SEED) do |i|
  user_name = Faker::Sports::Football.player
  user_first_name = user_name.split(' ').first
  user_last_name = user_name.split(' ').last
  user_email = Faker::Internet.email
  user_admin = if i == 1
                 true
               else
                 false
               end
  users.push User.create(first_name: user_first_name, last_name: user_last_name, email: user_email, admin: user_admin)
end

# seed tests
tests = []
TESTS_SEED.times do
  test_title = Faker::Lorem.sentence(word_count: 4)
  test_level = rand(1..5)
  test_category_id = categories.map(&:id).sample
  test_author = User.first
  tests.push(Test.create!(title: test_title, level: test_level, category_id: test_category_id, author: test_author))
end

# seed questions
questions = []
QUESTIONS_SEED.times do
  question_body = Faker::Lorem.question
  question_test_id = tests.map(&:id).sample
  questions.push(Question.create(body: question_body, test_id: question_test_id))
end

# seed answers
answers = []
ANSWERS_SEED.times do
  answer_body = Faker::Lorem.paragraph(sentence_count: 2)
  answer_question_id = questions.map(&:id).sample
  answer_correct = [true, false].sample
  answers.push Answer.create(body: answer_body, question_id: answer_question_id, correct: answer_correct)
end

# make references between users and tests
1.upto(Test.count) do |n|
  test = Test.find(n)
  test.update(author_id: users.map(&:id).sample)

  user_test_user = users.map(&:id).sample
  user_test_test = tests.map(&:id).sample
  TestPassage.create(user_id: user_test_user, test_id: user_test_test)
end
