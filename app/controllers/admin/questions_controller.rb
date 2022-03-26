class Admin::QuestionsController < Admin::BaseController
  
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
  end

  def show
  end

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.new(question_params)
    if @question.save
      redirect_to admin_test_path(@test), notice: "Question successfully created"
    else
      flash.now[:error] = "Could not create Question"
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to admin_question_path(@question), notice: "Question successfully updated"
    else
      flash.now[:error] = "Could not update Question"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to admin_test_path(@question.test), notice: "Question successfully deleted"
    else
      flash.now[:error] = "Could not delete Question"
      render :edit
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
