class TestsController < ApplicationController
  before_action :find_test, only: %i[show]
  before_action :find_all_tests, only: %i[index]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
  end

  def show
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def find_all_tests
    @tests = Test.all
  end

  def rescue_with_record_not_found
    render inline: "Can't find test with id: #{params[:id]} [status: 404]"
  end
end
