class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show result update gist]

  # показывает форму
  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    gist_service = GistQuestionService.new(@test_passage.current_question)
    result = gist_service.call

    redirect_to @test_passage, flash_options(gist_service)
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def flash_options(gist_service)
    gist_service.success? ? { notice: t('.success') } : { alert:  t('.unsuccess') }
  end

end
