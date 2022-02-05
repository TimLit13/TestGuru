module ApplicationHelper
  def current_year
    Time.now.year
  end

  def link_to_github(author, repo)
    link_to 'Github', "https://github.com/#{author}/#{repo}", target: :_blank
  end
end
