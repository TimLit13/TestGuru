class TestsController < ApplicationController

  before_action :set_test, only: %i[start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    @tests = Test.where(ready: true)
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
    render inline: t('.test_not_found', id: params[:id])
  end
end
