module TestPassagesHelper
  TEST_PASSAGE_SUCCESS = 0.85

  def test_passage_success?(test_passage)
    if test_passage_score(test_passage) >= TEST_PASSAGE_SUCCESS
      true
    else
      false
    end
  end

  def test_passage_score(test_passage)
    test_passage.correct_question/test_passage.test.questions.count.to_f.round(2)
  end
end
