module TestPassagesHelper
  def test_passage_percentage(current_question_number, all_questions_count)
    ((current_question_number-1)*100/all_questions_count).round(0)
  end

  def test_timer(timer)
    timer < 10 ? "0#{timer}:00" : "#{timer}:00"
  end
end
