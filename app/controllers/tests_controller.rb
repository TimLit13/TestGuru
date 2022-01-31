class TestsController < ApplicationController
  before_action :find_test, only: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_record_not_found

  def index
    render inline: "Here should be tests list"
  end

  def show
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_record_not_found
    render inline: "Can't find test with id: #{params[:id]} [status: 404]"
  end
end
