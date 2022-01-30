class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index]

  def index
    @questions = @test.questions
  end

  def show
  end

  def create
  end

  def destroy
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
