class Admin::TestsController < Admin::BaseController

  before_action :set_test, only: %i[show start edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    @tests = Test.all
  end

  def show
  end

  def edit
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(tests_params)
    @test.author_id = current_user.id

    if @test.save
      redirect_to admin_tests_path, notice: 'Successfully created test'
    else
      flash.now[:alert] = "Could not create test"
      render :new
    end
  end

  def update
    if @test.update(tests_params)
      redirect_to admin_tests_path, notice: 'Successfully updated test'
    else
      flash.now[:alert] = "Could not update test"
      render :edit
    end
  end

  def destroy
    if @test.destroy
      redirect_to admin_tests_path, notice: 'Successfully deleted test'
    else
      flash.now[:alert] = "Could not delete test"
      render :edit
    end
  end

  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_with_record_not_found
    render inline: "Can't find test with id: #{params[:id]} [status: 404]"
  end

  def tests_params
    params.require(:test).permit(:title, :level, :category_id)
  end
end
