class Answer < ApplicationRecord
  belongs_to :question

  before_destroy :check_min_answers

  validates :body, presence: true
  validate :validate_max_answers, on: [:create, :save]

  scope :correct_answers, -> { where(correct: true) }

  private

  def validate_max_answers
    errors.add(
      :max_answers, 
      "Only 4 answers for question available"
    ) if question.answers.count >= 4
  end
  
  def check_min_answers
    if question.answers.count == 1
      errors.add(
      :min_answers,
      "Should be more than 1 answer"
      ) 
      throw(:abort)
    end
  end
end
