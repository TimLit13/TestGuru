class Admin::TestsController < Admin::BaseController

  before_action :set_test, only: %i[show edit update destroy]

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
    @test = current_user.author_tests.new(tests_params)

    if @test.save
      redirect_to admin_tests_path, notice: t('.success')
    else
      flash.now[:alert] = t('.unsuccess')
      render :new
    end
  end

  def update
    if @test.update(tests_params)
      redirect_to admin_tests_path, notice: t('.success_updated')
    else
      flash.now[:alert] = t('.not_updated')
      render :edit
    end
  end

  def destroy
    if @test.destroy
      redirect_to admin_tests_path, notice: t('.success_deleted')
    else
      flash.now[:alert] = t('.not_deleted')
      render :edit
    end
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_with_record_not_found
    render inline: t('.test_not_found', id: params[:id])
  end

  def tests_params
    params.require(:test).permit(:title, :level, :category_id)
  end
end
