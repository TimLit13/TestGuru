module SessionsHelper
  def show_flash_message
    if flash[:alert]
      content_tag :p, flash[:alert], class: 'flash alert'
    end
  end
end
