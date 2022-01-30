class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index]
  before_action :find_question, only: %i[show]

  def index
    @questions = @test.questions
  end

  def show
    render plain: @question.body
  end

  def create
  end

  def destroy
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  # def question_params
  #   params.require(:question).permit(:body)
  # end
end
