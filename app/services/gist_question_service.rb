class GistQuestionService

  # client: nil - для тестирования 
  # (использования иного клиента вместо git_hub_client)
  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || GitHubClient.new
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    @client.response.status == 201
  end

  private

  def gist_params
    {
      description: (I18n.t('services.gist_question_service.question_from', test: @test.title)),
      files: {
        (I18n.t('services.gist_question_service.file_name')) => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = []
    content.push(I18n.t('services.gist_question_service.question'))
    content.push(@question.body + "\n")
    content.push(I18n.t('services.gist_question_service.answers'))
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end
