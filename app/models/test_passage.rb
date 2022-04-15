class TestPassage < ApplicationRecord
  
  TEST_PASSAGE_SUCCESS = 0.85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_update :before_update_set_next_question

  def accept!(answer_ids)
    self.correct_question += 1 if (answer_ids && correct_answer?(answer_ids))
    save!
    finish_passage! if remaining_time_ends?
  end

  def completed?
    current_question.nil?
  end

  def test_passage_success?
    self.test_passage_score >= TEST_PASSAGE_SUCCESS
  end

  def test_passage_score
    self.correct_question/self.test.questions.count.to_f.round(2)
  end

  def question_number
    self.test.questions.order(:id).where('id <= ?', self.current_question.id).length
  end

  def remaining_time_ends?
    Time.current >= self.created_at + self.test.timer.minutes
  end

  def any_remaining_time?
    !remaining_time_ends?
  end

  def finish_passage!
    self.current_question = nil
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first if current_question.present?
  end

  def before_update_set_next_question
    self.current_question = next_question
  end

end
