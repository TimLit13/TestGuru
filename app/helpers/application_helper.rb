module ApplicationHelper
  ALERTS = {
    notice: "info",
    error: "danger",
    success: "success",
    alert: "warning"
  }

  def current_year
    Time.now.year
  end

  def link_to_github(author, repo)
    link_to 'Github', "https://github.com/#{author}/#{repo}", target: :_blank, class: "link-secondary"
  end

  def flash_to_alert(flash)
    ALERTS[flash.to_sym]
  end
end
