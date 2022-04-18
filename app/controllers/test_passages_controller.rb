class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show result update gist]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  # показывает форму
  def show
  end

  def result
  end

  def update
    @test_passage.finish_passage! if @test_passage.remaining_time_ends?

    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed? || @test_passage.remaining_time_ends?
      @test_passage.update(completed: true) if @test_passage.test_passage_success? && @test_passage.any_remaining_time?
      # TestsMailer.completed_test(@test_passage).deliver_now

      achievement_service = AchievementService.new(@test_passage)

      if achievement_service.call && @test_passage.test_passage_success? 
        flash[:notice] = t('.get_achievement') + "#{ view_context.link_to(t('.reward'), achievements_path, target: :_blank) }"
      else
        flash[:alert] = t('.test_not_completed')
      end

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

  def rescue_with_record_not_found
    render inline: "Can't find test passage with id: #{params[:id]} [status: 404]"
  end
end
