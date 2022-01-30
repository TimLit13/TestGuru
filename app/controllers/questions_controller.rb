class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    @questions = @test.questions
  end

  def show
    render plain: @question.body
  end

  def new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to test_questions_path
    else
      render inline: @question.errors.full_messages
    end
  end

  def destroy
    if @question.destroy
      redirect_to test_questions_path(@question.test)
    else
      render plain: "Error whith destroy"
    end
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_record_not_found
    render inline: "Can't find question with id: #{params[:id]} [status: 404]"
  end
end
