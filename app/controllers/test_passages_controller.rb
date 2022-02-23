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

    if gist_service.success?
      create_gist(result)
      flash[:notice] = "#{ view_context.link_to('gist', result.html_url, target: :_blank) }" + t('.success') 
    else
      flash[:alert] = t('.unsuccess') 
    end 

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

# , link: result.html_url).}
  def create_gist(result)
    current_user.gists.create(
      author_id: current_user.id,
      question_id: @test_passage.current_question.id,
      url: result.html_url
    )
  end

end
