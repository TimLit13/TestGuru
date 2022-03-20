CATEGORIES_SEED = 2
TESTS_SEED = 5
ANSWERS_SEED = 4
USERS_SEED = 3
ADMINS_SEED = 1
QUESTIONS_SEED = 4

# clear db before seed
TestPassage.delete_all if TestPassage.any?
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
1.upto(ADMINS_SEED) do |i|
  user_name = 'Admin'
  user_first_name = 'Admin'
  user_last_name = 'Admin'
  user_email = 'admin@testguru.com'
  user_password = '11111111'
  user_admin = true
  users.push Admin.create(first_name: user_first_name, last_name: user_last_name, email: user_email, admin: user_admin, password: user_password)
end


1.upto(USERS_SEED) do |i|
  user_name = Faker::Sports::Football.player
  user_first_name = user_name.split(' ').first
  user_last_name = user_name.split(' ').last
  user_email = Faker::Internet.email
  user_admin = false
  password = '11111111'
  users.push User.create(first_name: user_first_name, last_name: user_last_name, email: user_email, admin: user_admin)
end


# seed tests
tests = []
questions = []

TESTS_SEED.times do
  test_title = Faker::Lorem.sentence(word_count: 4)
  test_level = rand(1..5)
  test_category_id = categories.map(&:id).sample
  test_author = Admin.first
  tests.push(Test.create!(title: test_title, level: test_level, category_id: test_category_id, author: test_author))
end

puts '*' * 80
puts "Tests successfully created"
puts '*' * 80

1.upto(tests.length) do |test_number|
  1.upto(QUESTIONS_SEED) do
    question_body = Faker::Lorem.question
    question_test_id = test_number
    questions.push(Question.create(body: question_body, test_id: question_test_id))
  end
end

puts '*' * 80
puts "Questions successfully created"
puts '*' * 80

1.upto(questions.length) do |question_number|
  1.upto(ANSWERS_SEED) do |answer_seed_number|
    answer_body = Faker::Lorem.paragraph(sentence_count: 2)
    answer_question_id = question_number
    answer_correct = if answer_seed_number == 1
                       true
                     else
                       false
                     end
    Answer.create(body: answer_body, question_id: answer_question_id, correct: answer_correct)
  end
end

puts '*' * 80
puts "Answers successfully created"
puts '*' * 80
