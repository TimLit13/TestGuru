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

  private

  def gist_params
    {
      description: "Question from #{@test.title}",
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = []
    content.push("Question:")
    content.push(@question.body)
    content.push("Answers:")
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

end
