class QuestionsController < ApplicationController
  def index
  end

  def show
  end

  def create
  end

  def destroy
  end

  private

  def question_params
    params.require(:question).permit(:id)
  end
end
