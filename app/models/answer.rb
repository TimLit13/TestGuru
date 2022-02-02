class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_max_answers, on: :create

  scope :correct_answers, -> { where(correct: true) }

  private

  def validate_max_answers
    errors.add(
      :max_answers, 
      'Only 4 answers for question available'
    ) if question.answers.count >= 4
  end
end
