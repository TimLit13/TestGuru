class Admin::TestsController < Admin::BaseController

  before_action :set_tests, only: %i[index update_inline]
  before_action :set_test, only: %i[show edit update destroy update_inline]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
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

  def update_inline
    if @test.update(tests_params)
      redirect_to admin_tests_path, notice: t('.success_updated')
    else
      flash.now[:alert] = t('.not_updated')
      render :index
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

  def set_tests
    @tests = Test.all
  end

  def rescue_with_record_not_found
    render inline: t('.test_not_found', id: params[:id])
  end

  def tests_params
    params.require(:test).permit(:title, :level, :category_id, :ready, :timer)
  end
end
