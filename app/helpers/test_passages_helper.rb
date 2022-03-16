module TestPassagesHelper
  def test_passage_percentage(current_question_number, all_questions_count)
    (current_question_number*100/all_questions_count).round(0)
  end
end
